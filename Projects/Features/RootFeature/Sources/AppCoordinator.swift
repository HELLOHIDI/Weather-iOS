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
}

extension AppCoordinator {
    private func runMainFlow() {
        let coordinator = MainCoordinator(
            router: router,
            factory: MainBuilder()
        )
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.checkDidSignIn()
            self?.removeDependency(coordinator)
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    private func checkDidSignIn() {
        let needAuth = UserDefaultKeyList.Auth.appAccessToken == nil
        needAuth ? runSignInFlow(by: .modal) : runMainFlow()
    }
}

//public class AppCoordinator: Coordinator {
//
//    public var childCoordinators: [Coordinator] = []
//    public var navigationController: UINavigationController
//
//    public init(navigationController: UINavigationController!) {
//        self.navigationController = navigationController
//    }
//
//    public func start() {
//        showMainViewController()
//    }
//
//    private func showMainViewController() {
//        let coordinator = DefaultMainCoordinator(navigationController: self.navigationController)
//        coordinator.delegate = self
//        coordinator.start()
//        self.childCoordinators.append(coordinator)
//    }
//
//    private func showDetailViewController(_ tag: Int) {
//        let coordinator = DefaultDetailCoordinator(navigationController: navigationController)
//        coordinator.start(tag)
//        self.childCoordinators.append(coordinator)
//    }
//}
//
//extension AppCoordinator: MainCoordinatorDelegate {
//    public func pushToDetailVC(_ coordinator: MainFeature.MainCoordinator, _ tag: Int) {
//        self.childCoordinators = self.childCoordinators.filter { $0 !== coordinator }
//        self.showDetailViewController(tag)
//    }
//}

