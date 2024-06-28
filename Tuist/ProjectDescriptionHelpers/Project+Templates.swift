import ProjectDescription
import ConfigPlugin
import EnvPlugin

public extension Project {
    static func makeModule(
        name: String,
        targets: Set<FeatureTarget> = Set([.staticFramework, .unitTest, .demo]),
        organizationName: String = "hellohidi",
        packages: [Package] = [],
        internalDependencies: [TargetDependency] = [],
        externalDependencies: [TargetDependency] = [],
        interfaceDependencies: [TargetDependency] = [],
        sources: SourceFilesList? = nil,
        resources: ResourceFileElements? = nil,
        infoPlist: InfoPlist = .extendingDefault(with: Project.appInfoPlist)
    ) -> Project {
        let configurationName: ConfigurationName = "Development"
        let hasDynamicFramework = targets.contains(.dynamicFramework)
        let deploymentTarget = Environment.deploymentTarget
        let platform = Environment.platform
        let baseSetting: SettingsDictionary = [:]
        
        var projectTargets: [Target] = []
        var schemes: [Scheme] = []
        
        // MARK: - APP
        
        if targets.contains(.app) {
            let bundleSuffix = name.contains("Demo") ? "test" : "release"
            let infoPlist = name.contains("Demo") ? Project.demoInfoPlist : Project.appInfoPlist
            let setting = baseSetting
            
            let target = Target(
                name: name,
                platform: platform,
                product: .app,
                bundleId: "\(Environment.bundlePrefix).\(bundleSuffix)",
                deploymentTarget: deploymentTarget,
                //infoPlist에 .extendingDefault로 Info.plsit에 추가 내용을 넣어준 이유는 tuist에서 .default 만들어주는 Info.plist는 앱을 실행할 때 화면이 어딘가 나사가 빠진상태로 실행되기 때문입니다.
                infoPlist: .extendingDefault(with: infoPlist),
                sources: ["Sources/**/*.swift"],
                // 터미널 명령어랑 비슷한듯? 일단 바쁘니까 나중에 정리해보도록 하자ㅏ https://www.daleseo.com/glob-patterns/#google_vignette
                resources: [.glob(pattern: "Resources/**", excluding: [])],
                //entitlement: 주로 iOS 애플리케이션에서 특정 기능이나 권한을 활성화하기 위해 사용하는 설정 파일
                entitlements: "\(name).entitlements",
                dependencies: [
                    internalDependencies,
                    externalDependencies
                ].flatMap { $0 },
                settings: .settings(base: setting, configurations: XCConfig.project)
            )
            projectTargets.append(target)
        }
        
        //MARK: - Feature Interface
        
        if targets.contains(.interface) {
            let setting = baseSetting
            let target = Target(
                name: "\(name)Interface",
                platform: platform,
                product: .framework,
                bundleId: "\(Environment.bundlePrefix).\(name)Interface",
                deploymentTarget: deploymentTarget,
                infoPlist: .default,
                sources: ["Interface/Sources/**/*.swift"],
                dependencies: internalDependencies,
                settings: .settings(base: setting,configurations: XCConfig.framework)
            )
            
            projectTargets.append(target)
        }
        
        //MARK: - Feature DemoApp
        
        if targets.contains(.demo) {
            let deps: [TargetDependency] = [.target(name:name)]
            let setting = baseSetting
            
            let target = Target(
                name: "\(name)Demo",
                platform: platform,
                product: .app,
                bundleId: "\(Environment.bundlePrefix).\(name)Demo",
                deploymentTarget: deploymentTarget,
                infoPlist: .extendingDefault(with: Project.demoInfoPlist),
                sources: ["Demo/Sources/**/*.swift"],
                resources: [.glob(pattern: "Demo/Resources/**", excluding: ["Demo/Resources/dummy.txt"])],
                dependencies: deps,
                settings: .settings(base: setting, configurations: XCConfig.demo)
            )
            projectTargets.append(target)
        }
        
        //MARK: - Unit Tests
        
        if targets.contains(.unitTest) {
            let deps: [TargetDependency] = [.target(name: name)]
            
            let target = Target(
                name: "\(name)Tests",
                platform: platform,
                product: .unitTests,
                bundleId: "\(Environment.bundlePrefix).\(name)Tests",
                deploymentTarget: deploymentTarget,
                infoPlist: .default,
                sources: ["Tests/Sources/**/*.swift"],
                resources: [.glob(pattern: "Tests/Resources/**", excluding: [])],
                dependencies: deps,
                settings: .settings(base: SettingsDictionary().setCodeSignManual(), configurations: XCConfig.tests)
            )
            
            projectTargets.append(target)
        }
        
        let additionalSchemes = targets.contains(.demo) ? [Scheme.makeScheme(configs: configurationName, name: name), Scheme.makeDemoScheme(configs: configurationName, name: name)] : [Scheme.makeScheme(configs: configurationName, name: name)]
        
        schemes += additionalSchemes
        
        
        var scheme = targets.contains(.app) ? appSchemes : schemes
        
        if name.contains("Demo") {
            let testAppScheme = Scheme.makeScheme(configs: "QA", name: name)
            scheme.append(testAppScheme)
        }
        
        return Project(
            name: name,
            organizationName: Environment.workspaceName,
            packages: packages,
            settings: .settings(configurations: XCConfig.project),
            targets: projectTargets,
            schemes: schemes
        )
    }
}

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

extension Project {
    static let appSchemes: [Scheme] = [
        // PROD API, debug scheme
        .init(
            name: "\(Environment.workspaceName)-DEV",
            shared: true,
            buildAction: .buildAction(targets: ["\(Environment.workspaceName)"]),
            testAction: .targets(
                ["\(Environment.workspaceName)Tests", "\(Environment.workspaceName)UITests"],
                configuration: "Development",
                options: .options(coverage: true, codeCoverageTargets: ["\(Environment.workspaceName)"])
            ),
            runAction: .runAction(configuration: "Development"),
            archiveAction: .archiveAction(configuration: "Development"),
            profileAction: .profileAction(configuration: "Development"),
            analyzeAction: .analyzeAction(configuration: "Development")
        ),
        // Test API, debug scheme
        .init(
            name: "\(Environment.workspaceName)-Test",
            shared: true,
            buildAction: .buildAction(targets: ["\(Environment.workspaceName)"]),
            testAction: .targets(
                ["\(Environment.workspaceName)Tests", "\(Environment.workspaceName)UITests"],
                configuration: "Test",
                options: .options(coverage: true, codeCoverageTargets: ["\(Environment.workspaceName)"])
            ),
            runAction: .runAction(configuration: "Test"),
            archiveAction: .archiveAction(configuration: "Test"),
            profileAction: .profileAction(configuration: "Test"),
            analyzeAction: .analyzeAction(configuration: "Test")
        ),
        // Test API, release scheme
        .init(
            name: "\(Environment.workspaceName)-QA",
            shared: true,
            buildAction: .buildAction(targets: ["\(Environment.workspaceName)"]),
            runAction: .runAction(configuration: "QA"),
            archiveAction: .archiveAction(configuration: "QA"),
            profileAction: .profileAction(configuration: "QA"),
            analyzeAction: .analyzeAction(configuration: "QA")
        ),
        // PROD API, release scheme
        .init(
            name: "\(Environment.workspaceName)-PROD",
            shared: true,
            buildAction: .buildAction(targets: ["\(Environment.workspaceName)"]),
            runAction: .runAction(configuration: "PROD"),
            archiveAction: .archiveAction(configuration: "PROD"),
            profileAction: .profileAction(configuration: "PROD"),
            analyzeAction: .analyzeAction(configuration: "PROD")
        ),
        // Test API, debug scheme, Demo App Target
        .makeDemoAppTestScheme()
    ]
}




    
    
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
    //        // MARK: - Schemes
    //
    //        let additionalSchemes = targets.contains(.demo) // 타겟이 데모앱을 가지고 있는다면
    //        ? [Scheme.makeScheme(configs: configurationName, name: name), // 그냥 스킴이랑
    //           Scheme.makeDemoScheme(configs: configurationName, name: name)] // 데모앱 스킴을 같이 가지게 되고
    //        : [Scheme.makeScheme(configs: configurationName, name: name)] // 아니면 (테스트데모, 피쳐, 테스트, 인터페이스) 그냥 스킴만 가지고
    //        schemes += additionalSchemes // 그것을 배열에다가 더해준다
    //
    //        var scheme = targets.contains(.app) // 타겟이 앱이면 걍 다 가지고 잇어야 됨
    //        ? appSchemes
    //        : schemes
    //
    //        if name.contains("Demo") { // 데모앱이다라는 뜻은
    //            let testAppScheme = Scheme.makeScheme(configs: "QA", name: name) // 테스트서버 + 릴리즈에서 확인을 해야함으로 QA 스킴 추가
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
    
    //    static func makeScheme(configs: ConfigurationName, name: String) -> Scheme { // 일반앱
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
    //    static func makeDemoScheme(configs: ConfigurationName, name: String) -> Scheme { // 데모앱
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
    //    static func makeDemoAppTestScheme() -> Scheme { // 데모테스트앱
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
