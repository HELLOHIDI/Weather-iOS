//
//  Enviroment.swift
//  EnvPlugin
//
//  Created by 류희재 on 2023/10/19.
//

import ProjectDescription

/// 프로젝트 환경 관련 파일입니다

public struct ProjectEnvironment {
    public let workspaceName: String
    public let deploymentTarget: DeploymentTarget
    public let platform: Platform
    public let bundlePrefix: String
}

public let env = ProjectEnvironment(
    workspaceName: "Weather-iOS",
    deploymentTarget: DeploymentTarget.iOS(targetVersion: "17.0", devices: [.iphone]),
    platform: .iOS,
    bundlePrefix: "com.Weather-iOS"
)
