//
//  APIUtils.swift
//  CleanMVVMExample
//
//  Created by Sergio Orozco  on 22/02/21.
//

import Foundation

public enum HTTPMethodType: String {
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}

enum RequestGenerationError: Error {
    case components
}

public protocol Requestable {
    var url: String {get set}
    var method: HTTPMethodType { get }
    var headerParamaters: [String: String] { get set }
    var queryParameters: [String: Any] { get }
    var bodyParamaters: [String: Any] { get }
    
    func urlRequest(with config: ServiceConfigurable) throws -> URLRequest 
}

extension Requestable {
    
    private func url(with config: ServiceConfigurable) throws -> URL {
        let apiPath = config.apiPath + url
        
        guard var urlComponents = URLComponents(string: apiPath) else { throw RequestGenerationError.components }
        var urlQueryItems = [URLQueryItem]()
        
        let queryParameters = self.queryParameters
        
        queryParameters.forEach {
            urlQueryItems.append(URLQueryItem(name: $0.key, value: "\($0.value)"))
        }
        
        config.queryParameters.forEach {
            urlQueryItems.append(URLQueryItem(name: $0.key, value: $0.value))
        }
        
        urlComponents.queryItems = !urlQueryItems.isEmpty ? urlQueryItems : nil
        guard let url = urlComponents.url else { throw RequestGenerationError.components }
        return url
    }
    
    public func urlRequest(with config: ServiceConfigurable) throws -> URLRequest {
        let url = try self.url(with: config)
        var urlRequest = URLRequest(url: url)
        var allHeaders: [String: String] = config.basicHeaders
        headerParamaters.forEach { allHeaders.updateValue($1, forKey: $0)}
        
        if !bodyParamaters.isEmpty {
            urlRequest.httpBody = encodeBody(bodyParamaters: self.bodyParamaters)
        }
        
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = allHeaders
        return urlRequest
    }
    
    private func encodeBody(bodyParamaters: [String: Any]) -> Data? {
        return try? JSONSerialization.data(withJSONObject: bodyParamaters)
    }
    
}

public protocol EndpointType: ResponseRequestable {
    associatedtype Response
}

class Endpoint<R>: EndpointType {
    typealias Response = R
    
    var url: String
    var method: HTTPMethodType
    var headerParamaters: [String : String]
    var queryParameters: [String : Any]
    var bodyParamaters: [String : Any]
    var responseDecoder: ResponseDecoder
    
    init(url: String,
         method: HTTPMethodType = .get,
         headerParamaters: [String: String] = [:],
         queryParameters: [String : Any] = [:],
         bodyParamaters: [String: Any] = [:],
         responseDecoder: ResponseDecoder = JSONResponseDecoder()
         ) {
        self.url = url
        self.method = method
        self.headerParamaters = headerParamaters
        self.queryParameters = queryParameters
        self.bodyParamaters = bodyParamaters
        self.responseDecoder = responseDecoder
    }
    
}

private extension Encodable {
    func toDictionary() throws -> [String: Any]? {
        let data = try JSONEncoder().encode(self)
        let josnData = try JSONSerialization.jsonObject(with: data)
        return josnData as? [String : Any]
    }
}
