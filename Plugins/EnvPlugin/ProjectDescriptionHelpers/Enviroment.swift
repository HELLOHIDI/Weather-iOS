//
//  Enviroment.swift
//  EnvPlugin
//
//  Created by 류희재 on 2023/10/19.
//

import ProjectDescription

public enum Environment {
    public static let workspaceName = "Weather-iOS"
}

public extension Project {
    enum Environment {
        public static let workspaceName = "Weather-iOS"
        public static let deploymentTarget = DeploymentTarget.iOS(targetVersion: "16.0", devices: [.iphone])
        public static let platform = Platform.iOS
        public static let bundlePrefix = "com.Weather-iOS"
    }
}
