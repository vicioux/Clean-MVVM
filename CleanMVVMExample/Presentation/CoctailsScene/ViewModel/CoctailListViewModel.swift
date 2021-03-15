//
//  CoctailListViewModel.swift
//  CleanMVVMExample
//
//  Created by Sergio Orozco  on 5/03/21.
//

import Foundation

protocol CoctailListViewModelInput {
    func didSearch(query: String)
}

protocol CoctailListViewModelOutput {
    var items: Observable<[CoctailListItemViewModel]> { get }
}

protocol CoctailListViewModel: CoctailListViewModelInput, CoctailListViewModelOutput {}

final class DefaultCoctailListViewModel: CoctailListViewModel {
    
    private let searchCoctailsUseCase: SearchCoctailsUseCase
    
    let items: Observable<[CoctailListItemViewModel]> = Observable([])
    
    // MARK: - Init
    init(searchCoctailsUseCase: SearchCoctailsUseCase) {
        self.searchCoctailsUseCase = searchCoctailsUseCase
    }
    
    private func load() {
        searchCoctailsUseCase.execute(requestValue: .init(query: "margarita")) { result in
            switch result {
            case .success(let data):
                self.appendItems(data)
            case .failure(let error):
                self.handle(error: error)
            }
        }
    }
    
    private func resetItems() {
        items.value.removeAll()
    }
    
    private func appendItems(_ coctailList: Coctails) {
        items.value = coctailList.coctails.map(CoctailListItemViewModel.init)
    }
   
    private func handle(error: Error) {
        print(error.localizedDescription)
    }
    
}

// MARK: - INPUT. View event methods

extension DefaultCoctailListViewModel {
    func didSearch(query: String) {
        self.load()
    }
}
