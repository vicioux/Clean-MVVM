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

}

public final class DefaultNetworkService {
    private let sessionManager: NetworkSessionManager
    
    public init(sessionManager: NetworkSessionManager) {
        self.sessionManager = sessionManager
    }
    
}
