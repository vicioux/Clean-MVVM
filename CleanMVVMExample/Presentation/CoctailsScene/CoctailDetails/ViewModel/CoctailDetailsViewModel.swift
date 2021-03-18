//
//  CoctailDetailsViewModel.swift
//  CleanMVVMExample
//
//  Created by Sergio Orozco  on 18/03/21.
//

import Foundation

protocol CoctailDetailViewModelInput { }

protocol CoctailDetailViewModelOutput { }

protocol CoctailDetailsViewModel: CoctailDetailViewModelInput, CoctailDetailViewModelOutput { }

final class DefaultCoctailDetailsViewModel: CoctailDetailsViewModel {
    
}
