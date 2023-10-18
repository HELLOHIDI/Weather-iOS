//
//  Dependency+Project.swift
//  DependencyPlugin
//
//  Created by 류희재 on 2023/10/19.
//

import ProjectDescription

public extension Dep {
    struct Features {
        public struct Main {}
    }
    
    struct Modules {}
}

// MARK: - Root

public extension Dep {
    static let data = Dep.project(target: "Data", path: .data)

    static let domain = Dep.project(target: "Domain", path: .domain)
    
    static let core = Dep.project(target: "Core", path: .core)
}

// MARK: - Modules

public extension Dep.Modules {
    static let dsKit = Dep.project(target: "DSKit", path: .relativeToModules("DSKit"))
    
    static let networks = Dep.project(target: "Networks", path: .relativeToModules("Networks"))
    
    static let thirdPartyLibs = Dep.project(target: "ThirdPartyLibs", path: .relativeToModules("ThirdPartyLibs"))
}

// MARK: - Features

public extension Dep.Features {
    static func project(name: String, group: String) -> Dep { .project(target: "\(group)\(name)", path: .relativeToFeature("\(group)\(name)")) }
}

public extension Dep.Features.Main {
    static let group = "Main"
    
    static let Feature = Dep.Features.project(name: "Feature", group: group)
    static let Interface = Dep.Features.project(name: "\(group)FeatureInterface", group: group)
}


