//
//  DefaultCoctailRepository.swift
//  CleanMVVMExample
//
//  Created by Sergio Orozco  on 22/02/21.
//

import Foundation

final class DefaulCoctailRepository {
    private let dataTransferService: DataTransferService
    
    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

extension DefaulCoctailRepository: CoctailsRepository {
    
    func fetchCoctailList(query: String) async throws -> Coctails {
        let request = APIEndpoints().getCoctailList(queryParameters: ["s": query])
        let response = try await dataTransferService.request(with: request)
        return response.toDomain()
    }
}
