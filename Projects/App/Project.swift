//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 류희재 on 2023/10/19.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "Weather-iOS",
    platform: .iOS,
    product: .app,
    dependencies: [
        .project(target: "Features", path: .relativeToRoot("Projects/Features"))
    ],
    sources: ["Sources/**"],
    resources: ["Resources/**"],
    infoPlist: .extendingDefault(with: [
        "UIMainStoryboardFile": "",
        "UILaunchStoryboardName": "LaunchScreen",
        "ENABLE_TESTS": .boolean(true),
    ])
)
