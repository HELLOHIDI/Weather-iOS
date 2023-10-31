//
//  AppCoordinator.swift
//  ProjectDescriptionHelpers
//
//  Created by 류희재 on 2023/10/30.
//

import UIKit

import BaseFeatureDependency
import MainFeature
import DetailFeature

public class AppCoordinator: Coordinator {
    
    public var childCoordinators: [Coordinator] = []
    public var navigationController: UINavigationController
    
    var isMain = true
    
    public init(navigationController: UINavigationController!) {
        self.navigationController = navigationController
    }
    
    public func start() {
        if isMain { showMainViewController() }
    }
    
    private func showMainViewController() {
        let coordinator = DefaultMainCoordinator(navigationController: self.navigationController)
        coordinator.delegate = self
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
    
    private func showDetailViewController(_ tag: Int) {
        let coordinator = DefaultDetailCoordinator(navigationController: navigationController)
        coordinator.start(tag)
        self.childCoordinators.append(coordinator)
    }
}

extension AppCoordinator: MainCoordinatorDelegate {
    public func pushToDetailVC(_ coordinator: MainFeature.MainCoordinator, _ tag: Int) {
        self.childCoordinators = self.childCoordinators.filter { $0 !== coordinator }
        self.showDetailViewController(tag)
    }
}
