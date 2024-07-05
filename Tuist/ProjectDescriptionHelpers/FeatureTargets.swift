//
//  FeatureTargets.swift
//  ProjectDescriptionHelpers
//
//  Created by 류희재 on 6/24/24.
//

import Foundation
import ProjectDescription

public enum FeatureTarget {
    case app    // iOSApp
    case interface  // Feature Interface
    case dynamicFramework
    case staticFramework
    case unitTest   // Unit Test
    case demo   // Feature Excutable Test

    public var hasFramework: Bool {
        switch self {
        case .dynamicFramework, .staticFramework: return true
        default: return false
        }
    }
    public var hasDynamicFramework: Bool { return self == .dynamicFramework }
}


