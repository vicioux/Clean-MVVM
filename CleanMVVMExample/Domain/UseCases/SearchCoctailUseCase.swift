//
//  SearchCoctailUseCase.swift
//  CleanMVVMExample
//
//  Created by Sergio Andres Orozco Builes on 18/02/21.
//

import Foundation

protocol SearchCoctailsUseCase {    
    func execute(requestValue: SearchCoctailUseCaseRequest) async throws -> Coctails
}

final class DefaultSearchCoctailsUseCase: SearchCoctailsUseCase {
    
    private let coctailRepository: CoctailsRepository
    
    public init(coctailRepository: CoctailsRepository) {
        self.coctailRepository = coctailRepository
    }
    
    func execute(requestValue: SearchCoctailUseCaseRequest) async throws -> Coctails {
        let coctails = try await coctailRepository.fetchCoctailList(query: requestValue.query)
        return coctails
    }
}


struct SearchCoctailUseCaseRequest {
    let query: String
}
