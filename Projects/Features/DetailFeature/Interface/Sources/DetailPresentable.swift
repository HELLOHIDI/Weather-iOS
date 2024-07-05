//
//  DetailPresentable.swift
//  DetailFeatureInterface
//
//  Created by 류희재 on 7/5/24.
//  Copyright © 2024 Weather-iOS. All rights reserved.
//

import Foundation

import BaseFeatureDependency
import Core

public protocol DetailViewControllable: ViewControllable { }
public protocol DetailCoordinatable {}

public typealias DetailViewModelType = ViewModelType & DetailCoordinatable
public typealias DetailPresentable = (vc: DetailViewControllable, vm: any DetailViewModelType)


