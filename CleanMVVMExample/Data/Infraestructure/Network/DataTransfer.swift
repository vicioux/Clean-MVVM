//
//  DataTransfer.swift
//  CleanMVVMExample
//
//  Created by Sergio Orozco  on 25/02/21.
//

import Foundation

// MARK: - Data Transfer Error
public enum DataTransferError: Error {
    case noResponse
    case parsing(Error)
    case networkFailure(NetworkError)
    case resolvedNetworkFailure(Error)
}

// MARK: - Response Protocols
public protocol ResponseDecoder {
    func decode<T: Decodable>(_ data: Data) throws -> T
}

public protocol ResponseRequestable: Requestable {
    associatedtype Response
    
    var responseDecoder: ResponseDecoder { get }
}

// MARK: - DataTransferService Protocol
public protocol DataTransferService {
    typealias CompletionHandler<T> = (Result<T, DataTransferError>) -> Void
    
    func request<T: Decodable, E: ResponseRequestable>(with endpoint: E,
                                                       completion: @escaping CompletionHandler<T>) where E.Response == T
    
    func request<E: ResponseRequestable>(with endpoint: E,
                                         completion: @escaping CompletionHandler<Void>) where E.Response == Void
}

// MARK: - DataTransferErrorResolver Protocol
public protocol DataTransferErrorResolver {
    func resolve(error: NetworkError) -> Error
}

public class DefaultDataTransferErrorResolver: DataTransferErrorResolver {
    public init() {}
    
    public func resolve(error: NetworkError) -> Error {
        return error
    }
}

// MARK: - DataTransferService Implementation
public final class DefaultDataTransferService {
    private let networkService: NetworkService
    private let errorResolver: DataTransferErrorResolver
    
    public init(with networkService: NetworkService,
                errorResolver: DataTransferErrorResolver) {
        self.networkService = networkService
        self.errorResolver = errorResolver
    }
}

extension DefaultDataTransferService: DataTransferService {
    
    public func request<T, E>(with endpoint: E,
                              completion: @escaping CompletionHandler<T>) where T : Decodable, T == E.Response, E : ResponseRequestable {
        self.networkService.request(endpoint: endpoint) { result in
            switch result {
            case .success(let data):
                let result: Result<T, DataTransferError> = self.decode(data: data, decoder: endpoint.responseDecoder)
                DispatchQueue.main.async { completion(result) }
            case .failure(let error):
                let error = self.resolve(networkError: error)
                DispatchQueue.main.async { completion(.failure(error)) }
            }
        }
    }
    
    public func request<E>(with endpoint: E, completion: @escaping CompletionHandler<Void>) where E : ResponseRequestable, E.Response == Void {
        
        self.networkService.request(endpoint: endpoint) { result in
            switch result {
            case .success:
                DispatchQueue.main.async { completion(.success(())) }
            case .failure(let error):
                let error = self.resolve(networkError: error)
                DispatchQueue.main.async { completion(.failure(error)) }
            }
        }
    }
    
    private func decode<T: Decodable>(data: Data?, decoder: ResponseDecoder) -> Result<T, DataTransferError> {
        do {
            guard let data = data else { return .failure(.noResponse) }
            let result: T = try decoder.decode(data)
            return .success(result)
        } catch {
            return .failure(.parsing(error))
        }
    }
    
    private func resolve(networkError error: NetworkError) -> DataTransferError {
        let resolvedError = self.errorResolver.resolve(error: error)
        return resolvedError is NetworkError ? .networkFailure(error) : .resolvedNetworkFailure(resolvedError)
    }
    
}

public class JSONResponseDecoder: ResponseDecoder {
    private let jsonDecoder = JSONDecoder()
    public init() { }
    
    public func decode<T>(_ data: Data) throws -> T where T : Decodable {
        return try jsonDecoder.decode(T.self, from: data)
    }
}
