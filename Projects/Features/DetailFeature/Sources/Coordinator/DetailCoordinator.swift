//
//  DetailCoordinator.swift
//  DetailFeatureInterface
//
//  Created by 류희재 on 7/5/24.
//  Copyright © 2024 Weather-iOS. All rights reserved.
//

import BaseFeatureDependency
import Core
import DetailFeatureInterface

public enum DetailCoordinatorDestination {
    case detail
}
public protocol DetailCoordinatorOutput {
    var requestCoordinating: ((DetailCoordinatorDestination) -> Void)? { get set }
}
public typealias DefaultDetailCoordinator = BaseCoordinator & DetailCoordinatorOutput

public
final class DetailCoordinator: DefaultDetailCoordinator {
    
    public var requestCoordinating: ((DetailCoordinatorDestination) -> Void)?
    
    private let factory: DetailFeatureViewBuildable
    private let router: Router
    
    public init(router: Router, factory: DetailFeatureViewBuildable) {
        self.factory = factory
        self.router = router
    }
    
    public override func start() {
        var main = factory.makeDetail()
        
    }
}

