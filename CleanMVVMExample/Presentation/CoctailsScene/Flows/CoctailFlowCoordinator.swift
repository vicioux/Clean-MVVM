//
//  CoctailFlowCoordinator.swift
//  CleanMVVMExample
//
//  Created by Sergio Orozco  on 3/03/21.
//

import UIKit

class CoctailFlowCoordinator {
    
    private weak var navigationController: UINavigationController?
    private weak var coctailListVC: CoctailListViewController?
    private let dependencies: CoctailSearchFlowCoordinatorDependencies
    
    init(dependencies: CoctailSearchFlowCoordinatorDependencies, navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        
        let actions = CoctailListViewModelActions(showCoctailDetails: showCoctailDetails)
        
        let vc = dependencies.makeCoctailListViewController(actions: actions)
        navigationController?.pushViewController(vc, animated: false)
        coctailListVC = vc
    }
    
    func showCoctailDetails(coctail: Coctail) {
        print("pass here honey")
    }
    
    
}
