//
//  MainPresentable.swift
//  MainFeatureManifests
//
//  Created by 류희재 on 6/28/24.
//

import Foundation

import BaseFeatureDependency
import Core

public protocol MainViewControllable: ViewControllable { }
public protocol MainCoordinatable {
}
public typealias MainViewModelType = ViewModelType & MainCoordinatable
public typealias MainPresentable = (vc: MainViewControllable, vm: any MainViewModelType)


