//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 류희재 on 2023/10/19.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "Features",
    product: .staticFramework,
    dependencies: [
        .project(target: "ThirdPartyLibs", path: .relativeToRoot("Projects/ThirdPartyLibs"))
    ],
    sources: ["Sources/**"]
)
