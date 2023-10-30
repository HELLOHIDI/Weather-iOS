//
//  DetailCoordinator.swift
//  DetailFeature
//
//  Created by 류희재 on 2023/10/30.
//  Copyright © 2023 hellohidi. All rights reserved.


import UIKit

import BaseFeatureDependency
import Domain

public class DetailCoordinator: Coordinator {
    
    public var childCoordinators: [Coordinator] = []
    
    private var navigationController: UINavigationController!
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start(_ currentPage: Int) {
        let viewController = DetailPageViewController(
            viewModel: DetailViewModel(
                detailUseCase: DefaultDetailUseCase.init(currentPage)
            )
        )
        self.navigationController.pushViewController(viewController, animated: true)
    }
}

