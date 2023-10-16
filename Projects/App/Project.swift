//
//  Projects.swift
//  
//
//  Created by 류희재 on 2023/10/16.
//

import ProjectDescription
import ProjectDescriptionHelpers
import RyuHeeJaeAssignment

let project = Project.makeModule(
    name: "Weather-iOS",
    platform: .iOS,
    product: .app,
    dependencies: [
        .Projcet.Feature
    ],
    resources: ["Resources/**"],
    infoPlist: .extendingDefault(with: [
        "UIMainStoryboardFile": "",
        "UILaunchStoryboardName": "LaunchScreen"
//        "ENABLE_TESTS": .boolean(true),
    ])
)

