//
//  SearchCoctailUseCase.swift
//  CleanMVVMExample
//
//  Created by Sergio Andres Orozco Builes on 18/02/21.
//

import Foundation

protocol SearchCoctailsUseCase {
//    func execute(requestValue: SearchCoctailUseCaseRequest,
//                 completion: @escaping (Result<Coctails, Error>) -> Void)
    
    func execute(requestValue: SearchCoctailUseCaseRequest) async throws -> Coctails
}

final class DefaultSearchCoctailsUseCase: SearchCoctailsUseCase {
    
    private let coctailRepository: CoctailsRepository
    
    public init(coctailRepository: CoctailsRepository) {
        self.coctailRepository = coctailRepository
    }
    
    func execute(requestValue: SearchCoctailUseCaseRequest) async throws -> Coctails {
        await withCheckedContinuation({ continuation in
            coctailRepository.fetchCoctailList(query: requestValue.query) { result in
                do {
                    let coctails = try result.get()
                    continuation.resume(returning: coctails)
                } catch {
                    print("Something went wrong")
                }
            }
        })
    }
    
//    func execute(requestValue: SearchCoctailUseCaseRequest,
//                 completion: @escaping (Result<Coctails, Error>) -> Void) {
//
//        coctailRepository.fetchCoctailList(query: requestValue.query) { result in
//            completion(result)
//        }
//    }
}


struct SearchCoctailUseCaseRequest {
    let query: String
}
