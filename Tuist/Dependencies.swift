//
//  Dependencies.swift
//  RyuHeeJae_assignmentManifests
//
//  Created by 류희재 on 2023/10/19.
//

import ProjectDescription
import ProjectDescriptionHelpers

let spm = SwiftPackageManagerDependencies([
    .remote(url: "https://github.com/SnapKit/SnapKit.git", requirement: .upToNextMinor(from: "5.0.0")),
    .remote(url: "https://github.com/devxoul/Then", requirement: .upToNextMajor(from: "2")),
    .remote(url: "https://github.com/onevcat/Kingfisher.git", requirement: .upToNextMajor(from: "7.6.2")),
    .remote(url: "https://github.com/ReactiveX/RxSwift", requirement: .upToNextMajor(from: "6.6.0")),
    .remote(url: "https://github.com/RxSwiftCommunity/RxGesture", requirement: .upToNextMajor(from: "4.0.4")),
    .remote(url: "https://github.com/RxSwiftCommunity/RxDataSources", requirement: .upToNextMajor(from: "5.0.2")),
    .remote(url: "https://github.com/ReactorKit/ReactorKit", requirement: .upToNextMajor(from: "5.0"))
], baseSettings: Settings.settings(
))

let dependencies = Dependencies(
    swiftPackageManager: spm,
    platforms: [.iOS]
)
