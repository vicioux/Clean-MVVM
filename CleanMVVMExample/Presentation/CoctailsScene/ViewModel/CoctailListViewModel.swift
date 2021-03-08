//
//  CoctailListViewModel.swift
//  CleanMVVMExample
//
//  Created by Sergio Orozco  on 5/03/21.
//

import Foundation

protocol CoctailListViewModelInput {
    
}

protocol CoctailListViewModelOutput {
    
}


protocol CoctailListViewModel: CoctailListViewModelInput, CoctailListViewModelOutput {}

final class DefaultCoctailListViewModel: CoctailListViewModel {
    
}
