//
//  Dependency+SPM.swift
//  DependencyPlugin
//
//  Created by 류희재 on 2023/10/17.
//

import ProjectDescription

/// TargetDependency의 확장을 통해
/// 프로젝트 내 외부 라이브러리 종속성을 보다 체계적으로 관리하기 위한 유틸리티를 제공하는 파일

public extension TargetDependency {
    enum SPM {}
    enum Carthage {}
}

public extension TargetDependency.SPM {
    static let SnapKit = TargetDependency.external(name: "SnapKit")
    static let Then = TargetDependency.external(name: "Then")
    static let Kingfisher = TargetDependency.external(name: "Kingfisher")
    static let RxDataSources = TargetDependency.external(name: "RxDataSources")
    static let RxGesture = TargetDependency.external(name: "RxGesture")
    static let RxSwift = TargetDependency.external(name: "RxSwift")
    static let RxCocoa = TargetDependency.external(name: "RxCocoa")
    static let RxRelay = TargetDependency.external(name: "RxRelay")
    static let ReactorKit = TargetDependency.external(name: "ReactorKit")
}
