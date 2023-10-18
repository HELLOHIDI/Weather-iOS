//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 류희재 on 2023/10/19.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "Data",
    product: .staticFramework,
    dependencies: [
        .project(target: "Networks", path: .relativeToRoot("Projects/Networks")),
        .project(target: "Domain", path: .relativeToRoot("Projects/Domain"))
    ],
    sources: ["Sources/**"]
)

