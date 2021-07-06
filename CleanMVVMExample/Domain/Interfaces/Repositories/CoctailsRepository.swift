//
//  CoctailsRepository.swift
//  CleanMVVMExample
//
//  Created by Sergio Orozco  on 18/02/21.
//

import Foundation

protocol CoctailsRepository {
    func fetchCoctailList(query: String) async throws -> Coctails
}
