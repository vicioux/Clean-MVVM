//
//  APIEndpoints.swift
//  CleanMVVMExample
//
//  Created by Sergio Orozco  on 22/02/21.
//

import Foundation

struct APIEndpoints {
    func getCoctailList(queryParameters params: [String : Any]) -> Endpoint<CoctailsResponseDTO> {
        return Endpoint(url: "/search.php", queryParameters: params)
    }
}
