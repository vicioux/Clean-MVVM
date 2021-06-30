//
//  CoctailListItemViewModel.swift
//  CleanMVVMExample
//
//  Created by Sergio Orozco  on 8/03/21.
//

import Foundation

struct CoctailListItemViewModel: Equatable {
    let id: String
    let name: String
    let category: String
    let instructions: String?
    let imagePath: String?
    
    func getCoctail() -> Coctail {
        return Coctail(id: id, name: name, category: category, instructions: instructions, imagePath: imagePath)
    }
}

extension CoctailListItemViewModel {
    
    init(coctail: Coctail) {
        self.id = coctail.id
        self.name = coctail.name
        self.category = coctail.category ?? ""
        self.instructions = coctail.instructions
        self.imagePath = coctail.imagePath
    }
}
