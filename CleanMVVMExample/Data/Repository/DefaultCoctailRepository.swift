//
//  DefaultCoctailRepository.swift
//  CleanMVVMExample
//
//  Created by Sergio Orozco  on 22/02/21.
//

import Foundation

final class DefaulCoctailRepository {
    
}

extension DefaulCoctailRepository: CoctailsRepository {
    func fetchCoctailList(query: String, completion: @escaping (Result<[Coctail], Error>) -> Void) {
        
    }
}
