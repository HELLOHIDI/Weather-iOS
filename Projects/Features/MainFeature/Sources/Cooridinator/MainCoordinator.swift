//
//  MainCoordinator.swift
//  MainFeatureInterface
//
//  Created by 류희재 on 7/5/24.
//  Copyright © 2024 Weather-iOS. All rights reserved.
//

import BaseFeatureDependency
import Core
import MainFeatureInterface

//public enum MainCoordinatorDestination {
//    case detail
//}
//public protocol MainCoordinatorOutput {
//    var requestCoordinating: (() -> Void)? { get set }
//}
//public typealias DefaultMainCoordinator = BaseCoordinator & MainCoordinatorOutput

public
final class MainCoordinator: DefaultCoordinator {
    
    public var finishFlow: (() -> Void)?
    
    
    public var requestCoordinating: ((Int) -> Void)?
    
    private let factory: MainFeatureViewBuildable
    private let router: Router
    
    public init(router: Router, factory: MainFeatureViewBuildable) {
        self.factory = factory
        self.router = router
    }
    
    public override func start() {
        var main = factory.makeMain()
        
        main.vm.onWeatherCellTap = { [weak self] page in
            self?.requestCoordinating?(page)
        }
        router.setRootModule(main.vc, animated: true)
    }
}
