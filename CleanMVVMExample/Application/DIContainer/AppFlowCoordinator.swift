//
//  AppFlowCoordinator.swift
//  CleanMVVMExample
//
//  Created by Sergio Orozco  on 4/03/21.
//

import UIKit

final class AppFlowCoordinator {
    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    
    
    init(navigationController: UINavigationController,
         appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        let moviesSceneDIContainer = appDIContainer.makeCoctailSceneDIContainer()
        let flow = moviesSceneDIContainer.makeCoctailSearchFlowCoordinator(navigationController: navigationController)
        flow.start()
    }
}
