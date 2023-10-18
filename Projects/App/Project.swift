//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 류희재 on 2023/10/19.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin
import EnvPlugin

let project = Project.makeModule(
    name: Environment.workspaceName,
    product: .app,
    dependencies: [
        .Features.Main.Feature,
        .data
    ],
    sources: ["Sources/**"],
    resources: ["Resources/**"],
    infoPlist: .extendingDefault(with: [
        "UIMainStoryboardFile": "",
        "UILaunchStoryboardName": "LaunchScreen",
        "ENABLE_TESTS": .boolean(true),
    ])
)
