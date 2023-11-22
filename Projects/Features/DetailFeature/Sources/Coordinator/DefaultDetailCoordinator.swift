//
//  DetailCoordinator.swift
//  DetailFeature
//
//  Created by 류희재 on 2023/10/30.
//  Copyright © 2023 hellohidi. All rights reserved.


import UIKit

import BaseFeatureDependency
import Domain
import Networks
import Data

public class DefaultDetailCoordinator: DetailCoordinator {
    
    public var childCoordinators: [Coordinator] = []
    public var navigationController: UINavigationController
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start(_ currentPage: Int) {
        let viewController = DetailPageViewController(
            currentPage: currentPage, detailCoordinator: self
        )
        
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    public func popViewController() {
        self.navigationController.popViewController(animated: true)
    }
}
