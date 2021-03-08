//
//  AppDIContainer.swift
//  CleanMVVMExample
//
//  Created by Sergio Orozco  on 2/03/21.
//

import Foundation

final class AppDIContainer {
        
    func makeCoctailSceneDIContainer() -> CoctailsSceneDIContainer {
        return CoctailsSceneDIContainer()
    }
}
