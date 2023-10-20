//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 류희재 on 2023/10/19.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "DSKit",
    product: .staticFramework,
    dependencies: [
        .core
    ],
    sources: ["Sources/**"]
)
