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

public
final class DetailCoordinator: DefaultCoordinator {
    
    public var finishFlow: (() -> Void)?
    
    private let factory: DetailFeatureViewBuildable
    private let router: Router
    private let page: Int
    
    public init(
        router: Router,
        factory: DetailFeatureViewBuildable,
        page: Int
    ) {
        self.factory = factory
        self.router = router
        self.page = page
    }
    
    public override func start() {
        var detail = factory.makeDetail(with: page)
        
        detail.listButtonDidTap = { [weak self]  in
            self?.router.popModule()
            self?.finishFlow?()
        }
        router.push(detail)
        
    }
}

