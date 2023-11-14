//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 류희재 on 2023/10/30.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "BaseFeatureDependency",
    product: .framework,
    dependencies: [
        .Modules.dsKit,
        .domain
    ],
    sources: ["Sources/**"]
)

