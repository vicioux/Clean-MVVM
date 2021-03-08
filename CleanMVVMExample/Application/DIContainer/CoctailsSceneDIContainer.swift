//
//  CoctailsSceneDIContainer.swift
//  CleanMVVMExample
//
//  Created by Sergio Orozco  on 2/03/21.
//

import UIKit

final class CoctailsSceneDIContainer {
    
    // MARK: - Flow Coordinators
    func makeMoviesSerachGlowCoordinator(navigationController: UINavigationController) -> CoctailFlowCoordinator {
        return CoctailFlowCoordinator(navigationController: navigationController)
    }
}
