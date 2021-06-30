//
//  CoctailsSceneDIContainer.swift
//  CleanMVVMExample
//
//  Created by Sergio Orozco  on 2/03/21.
//

import UIKit
import SwiftUI


protocol CoctailSearchFlowCoordinatorDependencies  {
    func makeCoctailListViewController(actions: CoctailListViewModelActionsType) -> UIViewController
    func makeCoctailDetailViewController(coctail: Coctail) -> UIViewController
}

final class CoctailsSceneDIContainer {
    
    let apiDataTransferService: DataTransferService
    
    init(dataTransferService: DataTransferService) {
        self.apiDataTransferService = dataTransferService
    }
    
    // MARK: - Coctail List
    func makeCoctailListViewController(actions: CoctailListViewModelActionsType) -> UIViewController {
        
        if #available(iOS 13, *) {
            let view = CoctailListView(viewModelWrapper: CoctailListViewModelWrapper(viewModel: makeCoctailListViewModel(actions: actions)))
            return UIHostingController(rootView: view)
        }
        
        return CoctailListViewController(withViewModel: makeCoctailListViewModel(actions: actions))
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
    func makeCoctailDetailViewController(coctail: Coctail) -> UIViewController {
        
        if #available(iOS 13, *) {
            let view = CoctailDetailsView(viewModelWrapper:
                                            CoctailDetailsViewModelWrapper(viewModel: DefaultCoctailDetailsViewModel(coctail: coctail)))
            return UIHostingController(rootView: view)
        }
        
        return CoctailDetailsViewController(withViewModel:
                                                DefaultCoctailDetailsViewModel(coctail: coctail))
    
    }
    
}

extension CoctailsSceneDIContainer: CoctailSearchFlowCoordinatorDependencies { }
