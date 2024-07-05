//
//  CoordinatorFinishOutput.swift
//  BaseFeatureDependency
//
//  Created by 류희재 on 7/5/24.
//  Copyright © 2024 Weather-iOS. All rights reserved.
//

import Foundation

/// Coordinator가 자신의 플로우를 마쳤을 때 호출됩니다. 대개의 경우 removeDependency()가 호출됩니다.
public protocol CoordinatorFinishOutput {
    var finishFlow: (() -> Void)? { get set }
}

public typealias DefaultCoordinator = BaseCoordinator & CoordinatorFinishOutput
