//
//  ServiceConfigurable.swift
//  CleanMVVMExample
//
//  Created by Sergio Orozco  on 22/02/21.
//

import Foundation

public protocol ServiceConfigurable {
    var apiHost: String { get }
    var apiVersion: String { get }
    var apiKey: String { get }
    var apiPath: String { get }
    var basicHeaders: [String: String] { get }
    var queryParameters: [String: String] { get }
}

extension ServiceConfigurable {
    public var apiHost: String {
        return "https://www.thecocktaildb.com/api/json"
    }
    
    public var apiVersion: String {
        return "v1"
    }
    
    public var apiKey: String {
        return "1"
    }
    
    public var apiPath: String {
        return apiHost + "/" + apiVersion + "/" + apiKey
    }
    
    public var basicHeaders: [String: String] {
        return [:]
    }
    
    public var queryParameters: [String: String] {
        return [:]
    }
}

public struct DefaultConfig: ServiceConfigurable {
    
}

public class ServiceConfiguration {
    public static var configuration = DefaultConfig()
}
