import ProjectDescription
import EnvPlugin

public extension Project {
    static func makeModule(
        name: String,
        product: Product,
        organizationName: String = "hellohidi",
        packages: [Package] = [],
        deploymentTarget: DeploymentTarget? = Environment.deploymentTarget,
        dependencies: [TargetDependency] = [],
        sources: SourceFilesList? = nil,
        resources: ResourceFileElements? = nil,
        infoPlist: InfoPlist = .extendingDefault(with: Project.appInfoPlist)
    ) -> Project {
        let settings: Settings = .settings(
            base: [:],
            configurations: [
                .debug(name: .debug),
                .release(name: .release)
            ], defaultSettings: .recommended)

        let appTarget = Target(
            name: name,
            platform: Environment.platform, // iOS, macOS, tvOS, watchOS 같은 플랫폼
            product: product, // app, appClips, staticFramework, frameWork, unitTest 같은 product
            bundleId: "\(Environment.bundlePrefix).\(name)", // 번들 ID
            deploymentTarget: deploymentTarget, // 배포타겟을 설정 (+버전)
            infoPlist: infoPlist, // infoPlist
            sources: sources, //소스 코드의 경로
            resources: resources,
            dependencies: dependencies
        )

        let testTarget = Target(
            name: "\(name)Tests",
            platform: Environment.platform,
            product: .unitTests,
            bundleId: "\(Environment.bundlePrefix).\(name)Tests",
            deploymentTarget: deploymentTarget,
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [.target(name: name)]
        )

        let schemes: [Scheme] = [.makeScheme(target: .debug, name: name)]

        let targets: [Target] = [appTarget]

        return Project(
            name: name,
            organizationName: organizationName,
            packages: packages,
            settings: settings,
            targets: targets,
            schemes: schemes
        )
    }
}

extension Scheme {
    static func makeScheme(target: ConfigurationName, name: String) -> Scheme {
        return Scheme(
            name: name,
            shared: true,
            buildAction: .buildAction(targets: ["\(name)"]),
            testAction: .targets(
                ["\(name)Tests"],
                configuration: target,
                options: .options(coverage: true, codeCoverageTargets: ["\(name)"])
            ),
            runAction: .runAction(configuration: target),
            archiveAction: .archiveAction(configuration: target),
            profileAction: .profileAction(configuration: target),
            analyzeAction: .analyzeAction(configuration: target)
        )
    }
}
