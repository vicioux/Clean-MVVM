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
    
    func request<T: Decodable, E: ResponseRequestable>(with endpoint: E) async throws -> T where E.Response == T
    func request<E: ResponseRequestable>(with endpoint: E) async throws where E.Response == Void
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
    
    public func request<T: Decodable, E: ResponseRequestable>(with endpoint: E) async throws -> T where E.Response == T {
        let result = try await self.networkService.request(endpoint: endpoint)
        let decodeData: T = try await decode(data: result, decoder: endpoint.responseDecoder)
        return decodeData
    }
    
    public func request<E: ResponseRequestable>(with endpoint: E) async throws where E.Response == Void {
        let _ = try await self.networkService.request(endpoint: endpoint)
    }
    
    private func decode<T: Decodable>(data: Data?, decoder: ResponseDecoder) async throws -> T {
        guard let data = data else { throw DataTransferError.noResponse }
        
        do {
            let result: T = try decoder.decode(data)
            return result
        } catch (let error) {
            throw DataTransferError.parsing(error)
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
