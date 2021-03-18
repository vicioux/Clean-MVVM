//
//  CoctailListViewModel.swift
//  CleanMVVMExample
//
//  Created by Sergio Orozco  on 5/03/21.
//

import Foundation

protocol CoctailListViewModelActionsType {
    var showCoctailDetails: (Coctail) -> Void { get set }
}

struct CoctailListViewModelActions: CoctailListViewModelActionsType {
    var showCoctailDetails: (Coctail) -> Void
}

protocol CoctailListViewModelInput {
    func didSearch(query: String)
    func didSelectItem(at: Int)
}

protocol CoctailListViewModelOutput {
    var items: Observable<[CoctailListItemViewModel]> { get }
}

protocol CoctailListViewModel: CoctailListViewModelInput, CoctailListViewModelOutput {}

final class DefaultCoctailListViewModel: CoctailListViewModel {

    private let searchCoctailsUseCase: SearchCoctailsUseCase
    private let actions: CoctailListViewModelActionsType
    
    private var coctailList: Coctails?
    
    // MARK: - OUTPUT
    let items: Observable<[CoctailListItemViewModel]> = Observable([])
    
    // MARK: - Init
    init(searchCoctailsUseCase: SearchCoctailsUseCase, actions: CoctailListViewModelActionsType) {
        self.searchCoctailsUseCase = searchCoctailsUseCase
        self.actions = actions
    }
    
    private func load(query: String) {
        searchCoctailsUseCase.execute(requestValue: .init(query: query)) { result in
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
        coctailList = nil
    }
    
    private func appendItems(_ coctailList: Coctails) {
        self.coctailList = coctailList
        items.value = coctailList.coctails.map(CoctailListItemViewModel.init)
    }
   
    private func handle(error: Error) {
        print(error.localizedDescription)
    }
    
}

// MARK: - INPUT. View event methods

extension DefaultCoctailListViewModel {
    
    func didSearch(query: String) {
        self.load(query: query)
    }
    
    func didSelectItem(at: Int) {
        guard let coctailList = coctailList, !coctailList.coctails.isEmpty else {
            fatalError("Can't select that coctail")
        }
        actions.showCoctailDetails(coctailList.coctails[at])
    }
}
