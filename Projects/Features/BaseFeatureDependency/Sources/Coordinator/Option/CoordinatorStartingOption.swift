//
//  CoordinatorStartingOption.swift
//  BaseFeatureDependency
//
//  Created by 류희재 on 7/5/24.
//  Copyright © 2024 Weather-iOS. All rights reserved.
//

import Foundation

public enum CoordinatorStartingOption {
    case root
    case modal
    case push
    case rootWindow(animated: Bool, message: String?)
}
