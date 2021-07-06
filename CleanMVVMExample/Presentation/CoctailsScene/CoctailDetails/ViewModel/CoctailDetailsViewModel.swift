//
//  CoctailDetailsViewModel.swift
//  CleanMVVMExample
//
//  Created by Sergio Orozco  on 18/03/21.
//

import Foundation

protocol CoctailDetailViewModelInput { }

protocol CoctailDetailViewModelOutput {
    var name: String { get }
    var instructions: String { get }
    var category: String { get }
    var ingredients: [Ingredient] { get }
    var imagePath: URL { get }
    var coctailImage: Observable<Data?> { get }
}

protocol CoctailDetailsViewModel: CoctailDetailViewModelInput, CoctailDetailViewModelOutput { }

final class DefaultCoctailDetailsViewModel: CoctailDetailsViewModel {
    var name: String
    var instructions: String
    var category: String
    var ingredients: [Ingredient] = []
    var imagePath: URL
    
    let coctailImage: Observable<Data?> = Observable(nil)
    
    init(coctail: Coctail) {
        self.name = coctail.name
        self.instructions = coctail.instructions ?? ""
        self.category = coctail.category ?? "N/A"
        self.ingredients = coctail.ingredients
        
        guard let url = URL(string: coctail.imagePath ?? "") else {
            self.imagePath = URL(fileURLWithPath: "")
            return
        }
        self.imagePath = url
    }
}
