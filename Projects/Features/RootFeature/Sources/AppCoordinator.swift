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
    private var navigationController: UINavigationController!
    
    var isMain: Bool = true
    
    public init(navigationController: UINavigationController!) {
        self.navigationController = navigationController
    }
    
    public func start() {
        if isMain {
            showMainViewController()
        } else {
//            showDetailViewController(tag)
        }
    }
    
    private func showMainViewController() {
        let coordinator = MainCoordinator(navigationController: navigationController)
        coordinator.delegate = self
        coordinator.start()
        self.childCoordinators.append(coordinator)
        
    }
    
    private func showDetailViewController(_ tag: Int) {
        let coordinator = DetailCoordinator(navigationController: navigationController)
//        coordinator.delegate = self
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
