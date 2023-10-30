//
//  MainCoordinator.swift
//  MainFeature
//
//  Created by 류희재 on 2023/10/30.
//  Copyright © 2023 hellohidi. All rights reserved.
//

import UIKit

import BaseFeatureDependency
import Domain

public protocol MainCoordinatorDelegate {
    func pushToDetailVC(_ coordinator: MainCoordinator, _ tag: Int)
}

public class MainCoordinator: Coordinator {
    
    public var childCoordinators: [Coordinator] = []
    public var delegate: MainCoordinatorDelegate?
    
    private var navigationController: UINavigationController!
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        let viewController = MainViewController(
            viewModel: MainViewModel(
                mainUseCase: DefaultMainUseCase()
            )
        )
        viewController.mainDelegate = self
        self.navigationController.pushViewController(viewController, animated: true)
    }
}

extension MainCoordinator: MainViewControllerDelegate {
    func pushToDetailVC(_ tag: Int) {
        delegate?.pushToDetailVC(self, tag)
    }
}
