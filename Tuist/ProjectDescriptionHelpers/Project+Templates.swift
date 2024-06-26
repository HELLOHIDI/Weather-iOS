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
            sources: ["\(name)Tests/**"],
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
            // 각각의 액션에 대한 ConfigurationName을 설정해주는 단계
            buildAction: .buildAction(targets: ["\(name)"]),
            testAction: .targets(
                ["\(name)Tests"],
                configuration: target,
                options: .options(coverage: true, codeCoverageTargets: ["\(name)"]) // 코드 커버리지 타겟 추가하는 부분 (유닛테스트에서 따로 공부해야될부분)
            ),
            runAction: .runAction(configuration: target),
            archiveAction: .archiveAction(configuration: target),
            profileAction: .profileAction(configuration: target),
            analyzeAction: .analyzeAction(configuration: target)
        )
    }
}


//import Foundation
//import ProjectDescription
//
//public enum FeatureTarget {
//    case app    // iOSApp
//    case interface  // Feature Interface
//    case dynamicFramework
//    case staticFramework
//    case unitTest   // Unit Test
//    case uiTest // UI Test
//    case demo   // Feature Excutable Test
//
//    public var hasFramework: Bool {
//        switch self {
//        case .dynamicFramework, .staticFramework: return true
//        default: return false
//        }
//    }
//    public var hasDynamicFramework: Bool { return self == .dynamicFramework }
//}


//import Foundation
//import ProjectDescription
//import DependencyPlugin
//import EnvPlugin
//import ConfigPlugin
//
//public extension Project {
//    static func makeModule(
//        name: String,
//        targets: Set<FeatureTarget> = Set([.staticFramework, .unitTest, .demo]),
//        packages: [Package] = [],
//        internalDependencies: [TargetDependency] = [],  // 모듈간 의존성
//        externalDependencies: [TargetDependency] = [],  // 외부 라이브러리 의존성
//        interfaceDependencies: [TargetDependency] = [], // Feature Interface 의존성 (BaseFeatureDepenedency)
//        dependencies: [TargetDependency] = [],
//        hasResources: Bool = false
//    ) -> Project {
//        
//        let configurationName: ConfigurationName = "Development"
//        let hasDynamicFramework = targets.contains(.dynamicFramework) // ❓Framework 다시 공부하기 두개의 차이를 확실히 알아야 될거같음
//        let deploymentTarget = Environment.deploymentTarget // 빌드버전 같은 타겟
//        let platform = Environment.platform // iOS 플랫폼
//
//        let baseSettings: SettingsDictionary = .baseSettings.setCodeSignManual() // ❓
//
//        var projectTargets: [Target] = []
//        var schemes: [Scheme] = [] // ❓ Scheme에 대해서 제대로 공부해야될거 같다.
//
//        // MARK: - App
//        
//        if targets.contains(.app) {
//            let bundleSuffix = name.contains("Demo") ? "test" : "release"
//            let infoPlist = name.contains("Demo") ? Project.demoInfoPlist : Project.appInfoPlist
//            let settings = baseSettings.setProvisioning()
//            
//            let target = Target(
//                name: name,
//                platform: platform,
//                product: .app,
//                bundleId: "\(Environment.bundlePrefix).\(bundleSuffix)",
//                deploymentTarget: deploymentTarget,
//                infoPlist: .extendingDefault(with: infoPlist),
//                sources: ["Sources/**/*.swift"],
//                resources: [.glob(pattern: "Resources/**", excluding: [])],
//                entitlements: "\(name).entitlements",
//                dependencies: [
//                    internalDependencies,
//                    externalDependencies
//                ].flatMap { $0 },
//                settings: .settings(base: settings, configurations: XCConfig.project)
//            )
//            
//            projectTargets.append(target)
//        }
//        
//        // MARK: - Feature Interface
//        
//        if targets.contains(.interface) {
//            let settings = baseSettings
//            
//            let target = Target(
//                name: "\(name)Interface",
//                platform: platform,
//                product:.framework,
//                bundleId: "\(Environment.bundlePrefix).\(name)Interface",
//                deploymentTarget: deploymentTarget,
//                infoPlist: .default,
//                sources: ["Interface/Sources/**/*.swift"], //TODO: ViewController들도 전부 interface화 시키는게 인상적임
//                dependencies: interfaceDependencies,
//                settings: .settings(base: settings, configurations: XCConfig.framework)
//            )
//            
//            projectTargets.append(target)
//        }
//        
//        // MARK: - Framework
//        
//        if targets.contains(where: { $0.hasFramework }) {
//            let deps: [TargetDependency] = targets.contains(.interface)
//            ? [.target(name: "\(name)Interface")]
//            : []
//            let settings = baseSettings
//            
//            let target = Target(
//                name: name,
//                platform: platform,
//                product: hasDynamicFramework ? .framework : .staticFramework,
//                bundleId: "\(Environment.bundlePrefix).\(name)",
//                deploymentTarget: deploymentTarget,
//                infoPlist: .default,
//                sources: ["Sources/**/*.swift"],
//                resources: hasResources ? [.glob(pattern: "Resources/**", excluding: [])] : [],
//                dependencies: deps + internalDependencies + externalDependencies,
//                settings: .settings(base: settings, configurations: XCConfig.framework)
//            )
//            
//            projectTargets.append(target)
//        }
//        
//        // MARK: - Feature Executable
//        
//        if targets.contains(.demo) {
//            let deps: [TargetDependency] = [.target(name: name)]
//            
//            let target = Target(
//                name: "\(name)Demo",
//                platform: platform,
//                product: .app,
//                bundleId: "\(Environment.bundlePrefix).\(name)Demo",
//                deploymentTarget: deploymentTarget,
//                infoPlist: .extendingDefault(with: Project.demoInfoPlist),
//                sources: ["Demo/Sources/**/*.swift"],
//                resources: [.glob(pattern: "Demo/Resources/**", excluding: ["Demo/Resources/dummy.txt"])],
//                dependencies: deps,
//                settings: .settings(base: baseSettings, configurations: XCConfig.demo)
//            )
//            
//            projectTargets.append(target)
//        }
//        
//        // MARK: - Unit Tests
//        
//        if targets.contains(.unitTest) {
//            let deps: [TargetDependency] = [.target(name: name)]
//            
//            let target = Target(
//                name: "\(name)Tests",
//                platform: platform,
//                product: .unitTests,
//                bundleId: "\(Environment.bundlePrefix).\(name)Tests",
//                deploymentTarget: deploymentTarget,
//                infoPlist: .default,
//                sources: ["Tests/Sources/**/*.swift"],
//                resources: [.glob(pattern: "Tests/Resources/**", excluding: [])],
//                dependencies: deps,
//                settings: .settings(base: SettingsDictionary().setCodeSignManual(), configurations: XCConfig.tests)
//            )
//            
//            projectTargets.append(target)
//        }
//        
//        // MARK: - UI Tests
//        
//        if targets.contains(.uiTest) {
//            let deps: [TargetDependency] = targets.contains(.demo)
//            ? [.target(name: name), .target(name: "\(name)Demo")] : [.target(name: name)]
//            
//            let target = Target(
//                name: "\(name)UITests",
//                platform: platform,
//                product: .uiTests,
//                bundleId: "\(Environment.bundlePrefix).\(name)UITests",
//                deploymentTarget: deploymentTarget,
//                infoPlist: .default,
//                sources: ["UITests/Sources/**/*.swift"],
//                dependencies: deps,
//                settings: .settings(base: SettingsDictionary().setCodeSignManual(), configurations: XCConfig.tests)
//            )
//            
//            projectTargets.append(target)
//        }
//        
//        // MARK: - Schemes
//        
//        let additionalSchemes = targets.contains(.demo) // 타겟이 데모앱을 가지고 있는다면
//        ? [Scheme.makeScheme(configs: configurationName, name: name), // 그냥 스킴이랑
//           Scheme.makeDemoScheme(configs: configurationName, name: name)] // 데모앱 스킴을 같이 가지게 되고
//        : [Scheme.makeScheme(configs: configurationName, name: name)] // 아니면 그냥 스킴만 가지고
//        schemes += additionalSchemes // 그것을 배열에다가 더해준다
//
//        var scheme = targets.contains(.app) // 타겟이 앱을 포함하고 잇다면 앱 스킴도 추가해주고요
//        ? appSchemes
//        : schemes
//        
//        if name.contains("Demo") {
//            let testAppScheme = Scheme.makeScheme(configs: "QA", name: name)
//            scheme.append(testAppScheme)
//        }
//        
//        return Project(
//            name: name,
//            organizationName: Environment.workspaceName,
//            packages: packages,
//            settings: .settings(configurations: XCConfig.project),
//            targets: projectTargets,
//            schemes: scheme
//        )
//    }
//}
//
//extension Scheme {
//    /// Scheme 생성하는 method
//    static func makeScheme(configs: ConfigurationName, name: String) -> Scheme {
//        return Scheme(
//            name: name,
//            shared: true,
//            buildAction: .buildAction(targets: ["\(name)"]),
//            testAction: .targets(
//                ["\(name)Tests"],
//                configuration: configs,
//                options: .options(coverage: true, codeCoverageTargets: ["\(name)"])
//            ),
//            runAction: .runAction(configuration: configs),
//            archiveAction: .archiveAction(configuration: configs),
//            profileAction: .profileAction(configuration: configs),
//            analyzeAction: .analyzeAction(configuration: configs)
//        )
//    }
//    
//    static func makeDemoScheme(configs: ConfigurationName, name: String) -> Scheme {
//        return Scheme(
//            name: "\(name)Demo",
//            shared: true,
//            buildAction: .buildAction(targets: ["\(name)Demo"]),
//            testAction: .targets(
//                ["\(name)Tests"],
//                configuration: configs,
//                options: .options(coverage: true, codeCoverageTargets: ["\(name)Demo"])
//            ),
//            runAction: .runAction(configuration: configs),
//            archiveAction: .archiveAction(configuration: configs),
//            profileAction: .profileAction(configuration: configs),
//            analyzeAction: .analyzeAction(configuration: configs)
//        )
//    }
//    
//    static func makeDemoAppTestScheme() -> Scheme {
//        let targetName = "\(Environment.workspaceName)-Demo"
//        return Scheme(
//          name: "\(targetName)-Test",
//          shared: true,
//          buildAction: .buildAction(targets: ["\(targetName)"]),
//          testAction: .targets(
//              ["\(targetName)Tests"],
//              configuration: "Test",
//              options: .options(coverage: true, codeCoverageTargets: ["\(targetName)"])
//          ),
//          runAction: .runAction(configuration: "Test"),
//          archiveAction: .archiveAction(configuration: "Test"),
//          profileAction: .profileAction(configuration: "Test"),
//          analyzeAction: .analyzeAction(configuration: "Test")
//        )
//    }
//}
//
//extension Project {
//    static let appSchemes: [Scheme] = [
//        // PROD API, debug scheme
//        .init(
//            name: "\(Environment.workspaceName)-DEV",
//            shared: true,
//            buildAction: .buildAction(targets: ["\(Environment.workspaceName)"]),
//            testAction: .targets(
//                ["\(Environment.workspaceName)Tests", "\(Environment.workspaceName)UITests"],
//                configuration: "Development",
//                options: .options(coverage: true, codeCoverageTargets: ["\(Environment.workspaceName)"])
//            ),
//            runAction: .runAction(configuration: "Development"),
//            archiveAction: .archiveAction(configuration: "Development"),
//            profileAction: .profileAction(configuration: "Development"),
//            analyzeAction: .analyzeAction(configuration: "Development")
//        ),
//        // Test API, debug scheme
//        .init(
//            name: "\(Environment.workspaceName)-Test",
//            shared: true,
//            buildAction: .buildAction(targets: ["\(Environment.workspaceName)"]),
//            testAction: .targets(
//                ["\(Environment.workspaceName)Tests", "\(Environment.workspaceName)UITests"],
//                configuration: "Test",
//                options: .options(coverage: true, codeCoverageTargets: ["\(Environment.workspaceName)"])
//            ),
//            runAction: .runAction(configuration: "Test"),
//            archiveAction: .archiveAction(configuration: "Test"),
//            profileAction: .profileAction(configuration: "Test"),
//            analyzeAction: .analyzeAction(configuration: "Test")
//        ),
//        // Test API, release scheme
//        .init(
//            name: "\(Environment.workspaceName)-QA",
//            shared: true,
//            buildAction: .buildAction(targets: ["\(Environment.workspaceName)"]),
//            runAction: .runAction(configuration: "QA"),
//            archiveAction: .archiveAction(configuration: "QA"),
//            profileAction: .profileAction(configuration: "QA"),
//            analyzeAction: .analyzeAction(configuration: "QA")
//        ),
//        // PROD API, release scheme
//        .init(
//            name: "\(Environment.workspaceName)-PROD",
//            shared: true,
//            buildAction: .buildAction(targets: ["\(Environment.workspaceName)"]),
//            runAction: .runAction(configuration: "PROD"),
//            archiveAction: .archiveAction(configuration: "PROD"),
//            profileAction: .profileAction(configuration: "PROD"),
//            analyzeAction: .analyzeAction(configuration: "PROD")
//        ),
//        // Test API, debug scheme, Demo App Target
//        .makeDemoAppTestScheme()
//    ]
//}
