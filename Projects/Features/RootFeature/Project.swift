//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 류희재 on 2023/10/23.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "RootFeature",
    product: .staticFramework,
    dependencies: [
        .Features.Main.Feature,
        .Features.Detail.Feature
    ],
    sources: ["Sources/**"]
)

