//
//  Coordinator.swift
//  ProjectDescriptionHelpers
//
//  Created by 류희재 on 2023/10/30.
//

public protocol Coordinator : AnyObject {
    var childCoordinators : [Coordinator] { get set }
}
