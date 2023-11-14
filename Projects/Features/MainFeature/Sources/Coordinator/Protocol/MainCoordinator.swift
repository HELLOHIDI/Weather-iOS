//
//  MainCoordinator.swift
//  MainFeature
//
//  Created by 류희재 on 2023/10/31.
//  Copyright © 2023 hellohidi. All rights reserved.
//

import Foundation
import BaseFeatureDependency

public protocol MainCoordinator: Coordinator {
    func pushToDetailVC(with page: Int)
}
