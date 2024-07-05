//
//  MainFeatureViewBuildable.swift
//  MainFeatureInterface
//
//  Created by 류희재 on 7/5/24.
//  Copyright © 2024 Weather-iOS. All rights reserved.
//

import Core

public protocol MainFeatureViewBuildable {
    func makeMain() -> MainPresentable
}
