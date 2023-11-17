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
import Data
import Networks

public protocol MainCoordinatorDelegate {
    func pushToDetailVC(_ coordinator: MainCoordinator, _ page: Int)
}

public class DefaultMainCoordinator: MainCoordinator {
    
    public var childCoordinators: [Coordinator] = []
    public var delegate: MainCoordinatorDelegate?
    public var navigationController: UINavigationController
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        let viewController = MainViewController(
            viewModel: MainViewModel(
                mainCoordinator: self,
                mainUseCase: DefaultMainUseCase(
                    repository: DefaultWeatherRepository(
                        urlSessionService: WeatherNetworkService()
                    )
                )
            )
        )
        self.navigationController.pushViewController(viewController, animated: true)
    }
}

extension DefaultMainCoordinator {
    public func pushToDetailVC(with page: Int) {
        delegate?.pushToDetailVC(self, page)
    }
}
