//
//  CoctailsSceneDIContainer.swift
//  CleanMVVMExample
//
//  Created by Sergio Orozco  on 2/03/21.
//

import UIKit


protocol CoctailSearchFlowCoordinatorDependencies  {
    func makeCoctailListViewController(actions: CoctailListViewModelActionsType) -> CoctailListViewController
    func makeCoctailDetailViewController() -> CoctailDetailsViewController
}

final class CoctailsSceneDIContainer {
    
    let apiDataTransferService: DataTransferService
    
    init(dataTransferService: DataTransferService) {
        self.apiDataTransferService = dataTransferService
    }
    
    // MARK: - Coctail List
    func makeCoctailListViewController(actions: CoctailListViewModelActionsType) ->  CoctailListViewController {
        CoctailListViewController(withViewModel: makeCoctailListViewModel(actions: actions))
    }
    
    // MARK: - ViewModel
    func makeCoctailListViewModel(actions: CoctailListViewModelActionsType) -> CoctailListViewModel {
        return DefaultCoctailListViewModel(searchCoctailsUseCase: makeSearchCoctailUserCase(), actions: actions)
    }
    
    // MARK: - Use Cases
    func makeSearchCoctailUserCase() -> SearchCoctailsUseCase {
        return DefaultSearchCoctailsUseCase(coctailRepository: makeCoctailsRepository())
    }
    
    // MARK: - Repositories
    func makeCoctailsRepository() -> CoctailsRepository {
        DefaulCoctailRepository(dataTransferService: apiDataTransferService)
    }
    
    // MARK: - Flow Coordinators
    func makeCoctailSearchFlowCoordinator(navigationController: UINavigationController) -> CoctailFlowCoordinator {
        return CoctailFlowCoordinator(dependencies: self, navigationController: navigationController)
    }
    
    // MARK: - Coctail Detail View
    func makeCoctailDetailViewController() -> CoctailDetailsViewController {
        return CoctailDetailsViewController(withViewModel: DefaultCoctailDetailsViewModel())
    }
    
}

extension CoctailsSceneDIContainer: CoctailSearchFlowCoordinatorDependencies { }
