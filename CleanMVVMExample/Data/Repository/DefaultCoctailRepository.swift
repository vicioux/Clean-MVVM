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
    func fetchCoctailList(query: String, completion: @escaping (Result<Coctails, Error>) -> Void) {
        let request = APIEndpoints().getCoctailList(queryParameters: ["s": query])
        
        dataTransferService.request(with: request) { result in
            switch result {
            case .success(let response):
                completion(.success(response.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
