//
//  SearchCoctailUseCase.swift
//  CleanMVVMExample
//
//  Created by Sergio Andres Orozco Builes on 18/02/21.
//

import Foundation

protocol SearchCoctailsUseCase {
    func execute(requestValue: SearchCoctailUseCaseRequest,
                 completion: @escaping (Result<Coctails, Error>) -> Void)
}

final class DefaultSearchCoctailsUseCase: SearchCoctailsUseCase {
    
    private let coctailRepository: CoctailsRepository
    
    public init(coctailRepository: CoctailsRepository) {
        self.coctailRepository = coctailRepository
    }
    
    func execute(requestValue: SearchCoctailUseCaseRequest,
                 completion: @escaping (Result<Coctails, Error>) -> Void) {
        
        coctailRepository.fetchCoctailList(query: requestValue.query) { result in
            completion(result)
        }
    }
}


struct SearchCoctailUseCaseRequest {
    let query: String
}
