//
//  AppCoordinator.swift
//  ProjectDescriptionHelpers
//
//  Created by 류희재 on 2023/10/30.
//

import UIKit

import Core
import BaseFeatureDependency
import MainFeature
import DetailFeature

public class AppCoordinator: BaseCoordinator {
    private let router: Router
    
    public init(router: Router) {
        self.router = router
        
        super.init()
    }
    
    public override func start() {
        runMainFlow()
    }
}

extension AppCoordinator {
    private func runMainFlow() {
        self.childCoordinators = []
        
        let coordinator = MainCoordinator(
            router: router,
            factory: MainBuilder()
        )
        coordinator.requestCoordinating = { [weak self] page in
            self?.runDetailFlow(with: page)
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    @discardableResult
    internal func runDetailFlow(with page: Int) -> DetailCoordinator {
        let coordinator = DetailCoordinator(
            router: Router(
                rootController: UIWindow.getRootNavigationController
            ),
            factory: DetailBuilder(),
            page: page
        )
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
        }
        addDependency(coordinator)
        coordinator.start()
        
        return coordinator
    }
}
