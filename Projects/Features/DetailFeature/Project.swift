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
    name: "DetailFeature",
    product: .staticFramework,
    dependencies: [
        .Features.BaseFeatureDependency
    ],
    sources: ["Sources/**"]
)
