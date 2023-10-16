//
//  Dependency+SPM.swift
//  MyPlugin
//
//  Created by 류희재 on 2023/10/16.
//

import ProjectDescription

public extension TargetDependency {
    enum SPM {}
}

public extension Package {
    static let SnapKit = Package.remote(
        url: "https://github.com/SnapKit/SnapKit",
        requirement: .upToNextMajor(from: "5.6.0")
    )
    static let Then = Package.remote(
        url: "https://github.com/devxoul/Then",
        requirement: .upToNextMajor(from: "2")
    )
    static let KingFisher = Package.remote(
        url: "https://github.com/onevcat/Kingfisher.git",
        requirement: .upToNextMajor(from: "7.9.0"))
    
    static let Rx = Package.remote(
        url: "https://github.com/ReactiveX/RxSwift.git",
        requirement: .upToNextMajor(from: "6.6.0")
    )
    
    static let RxGesture = Package.remote(
        url:"https://github.com/RxSwiftCommunity/RxGesture",
        requirement: .upToNextMajor(from: "4.0.4")
    )
    
    static let RxDataSource = Package.remote(
        url: "https://github.com/RxSwiftCommunity/RxDataSources",
        requirement: .upToNextMajor(from: "5.0.2")
    )
}

public extension TargetDependency.SPM {
    static let SnapKit = TargetDependency.package(product: "SnapKit")
    static let Then = TargetDependency.package(product: "Then")
    static let KingFisher = TargetDependency.package(product: "KingFisher")
    static let RxSwift = TargetDependency.package(product: "RxSwift")
    static let RxCocoa = TargetDependency.package(product: "RxCocoa")
    static let RxRelay = TargetDependency.package(product: "RxRelay")
}

