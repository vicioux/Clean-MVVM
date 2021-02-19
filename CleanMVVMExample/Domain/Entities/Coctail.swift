//
//  Coctail.swift
//  CleanMVVMExample
//
//  Created by Sergio Andres Orozco Builes on 18/02/21.
//

import Foundation

struct Coctail: Equatable, Identifiable {
    typealias Identifier = String

    let id: Identifier
    let name: String
    let category: String?
    let instructions: String?
    let tags: [String] = []
    let ingredients: [Ingredient] = []
    let imagePath: String?
}

struct Ingredient: Equatable {
    let name: String
    let measure: String?
}
