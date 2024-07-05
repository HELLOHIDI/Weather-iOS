//
//  MainCoordinator.swift
//  MainFeatureInterface
//
//  Created by 류희재 on 7/5/24.
//  Copyright © 2024 Weather-iOS. All rights reserved.
//

import BaseFeatureDependency
import Core

public enum MainCoordinatorDestination {
    case detail
}
public protocol MainCoordinatorOutput {
    var requestCoordinating: ((MainCoordinatorDestination) -> Void)? { get set }
}
public typealias DefaultMainCoordinator = BaseCoordinator & MainCoordinatorOutput

public
final class MainCoordinator: DefaultMainCoordinator {
    
    public var requestCoordinating: ((MainCoordinatorDestination) -> Void)?
    
    private let factory: MainFeatureViewBuildable
    private let router: Router
    
    public init(router: Router, factory: MainFeatureViewBuildable) {
        self.factory = factory
        self.router = router
    }
    
    public override func start() {
        var main = factory.makeMain()
        
        main.vm.onWeatherCellTap = { [weak self] page in
            self?.requestCoordinating?(.detail)
        }
        
    }
}
