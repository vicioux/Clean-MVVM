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
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = CoctailListViewController(withViewModel: DefaultCoctailListViewModel())
        navigationController?.pushViewController(vc, animated: false)
    }
}
