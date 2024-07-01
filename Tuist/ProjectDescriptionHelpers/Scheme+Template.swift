//
//  Scheme+Template.swift
//  ProjectDescriptionHelpers
//
//  Created by 류희재 on 7/1/24.
//

import ProjectDescription
import EnvPlugin

extension Scheme {
    /// Scheme 생성하는 method

    static func makeScheme(configs: ConfigurationName, name: String) -> Scheme { // 일반앱
        return Scheme(
            name: name,
            shared: true,
            buildAction: .buildAction(targets: ["\(name)"]),
            testAction: .targets(
                ["\(name)Tests"],
                configuration: configs,
                options: .options(coverage: true, codeCoverageTargets: ["\(name)"])
            ),
            runAction: .runAction(configuration: configs),
            archiveAction: .archiveAction(configuration: configs),
            profileAction: .profileAction(configuration: configs),
            analyzeAction: .analyzeAction(configuration: configs)
        )
    }

    static func makeDemoScheme(configs: ConfigurationName, name: String) -> Scheme { // 데모앱
        return Scheme(
            name: "\(name)Demo",
            shared: true,
            buildAction: .buildAction(targets: ["\(name)Demo"]),
            testAction: .targets(
                ["\(name)Tests"],
                configuration: configs,
                options: .options(coverage: true, codeCoverageTargets: ["\(name)Demo"])
            ),
            runAction: .runAction(configuration: configs),
            archiveAction: .archiveAction(configuration: configs),
            profileAction: .profileAction(configuration: configs),
            analyzeAction: .analyzeAction(configuration: configs)
        )
    }

    static func makeDemoAppTestScheme() -> Scheme { // 데모테스트앱
        let targetName = "\(Environment.workspaceName)-Demo"
        return Scheme(
          name: "\(targetName)-Test",
          shared: true,
          buildAction: .buildAction(targets: ["\(targetName)"]),
          testAction: .targets(
              ["\(targetName)Tests"],
              configuration: "Test",
              options: .options(coverage: true, codeCoverageTargets: ["\(targetName)"])
          ),
          runAction: .runAction(configuration: "Test"),
          archiveAction: .archiveAction(configuration: "Test"),
          profileAction: .profileAction(configuration: "Test"),
          analyzeAction: .analyzeAction(configuration: "Test")
        )
    }
}


