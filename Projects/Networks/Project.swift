//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 류희재 on 2023/10/19.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "Networks",
    product: .staticFramework,
    dependencies: [
        .project(target: "Core", path: .relativeToRoot("Projects/Core"))
    ],
    sources: ["Sources/**"]
)
