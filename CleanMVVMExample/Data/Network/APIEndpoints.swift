//
//  APIEndpoints.swift
//  CleanMVVMExample
//
//  Created by Sergio Orozco  on 22/02/21.
//

import Foundation

struct APIEndpoints {
    func getCoctailList() -> EndpointType {
        return Endpoint(url: "search.php")
    }
}
