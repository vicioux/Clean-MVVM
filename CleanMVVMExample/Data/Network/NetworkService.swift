//
//  NetworkService.swift
//  CleanMVVMExample
//
//  Created by Sergio Orozco  on 23/02/21.
//

import Foundation

// MARK: - NetworkError
public enum NetworkError: Error {
    case error(statusCode: Int, data: Data?)
    case notConnected
    case cancelled
    case generic(Error)
    case urlGeneration
}

// MARK: - Default Network Session Manager
public protocol NetworkSessionManager {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    
    func request(_ request: URLRequest, completion: @escaping CompletionHandler)
}

public class DefaultNetworkSessionManager: NetworkSessionManager {
    
    public init() {}
    
    public func request(_ request: URLRequest, completion: @escaping CompletionHandler) {
        URLSession.shared.dataTask(with: request, completionHandler: completion)
    }
}

// MARK: - Default Network Service
public protocol NetworkService {
    typealias CompletionHandler = (Result<Data?, NetworkError>) -> Void
}

public final class DefaultNetworkService {
    private let sessionManager: NetworkSessionManager
    
    public init(sessionManager: NetworkSessionManager) {
        self.sessionManager = sessionManager
    }
    
    public func request(request: URLRequest, completion: @escaping CompletionHandler) {
        sessionManager.request(request) { data, response, requestError in
            
            if let requestError = requestError {
                var error: NetworkError
                if let response = response as? HTTPURLResponse {
                    error = .error(statusCode: response.statusCode, data: data)
                } else {
                    error = self.resolve(error: requestError)
                }
                completion(.failure(error))
                return
            }
            
            completion(.success(data))
        }
    }
    
    private func resolve(error: Error) -> NetworkError {
        let code = URLError.Code(rawValue: (error as NSError).code)
        switch code {
        case .notConnectedToInternet: return .notConnected
        case .cancelled: return .cancelled
        default: return .generic(error)
        }
    }
}

extension DefaultNetworkService: NetworkService { }
