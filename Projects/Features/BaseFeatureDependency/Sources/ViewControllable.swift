//
//  ViewControllable.swift
//  BaseFeatureDependency
//
//  Created by 류희재 on 7/4/24.
//  Copyright © 2024 Weather-iOS. All rights reserved.
//

import UIKit

public protocol ViewControllable {
    var viewController: UIViewController { get }
    var asNavigationController: UINavigationController { get }
}
public extension ViewControllable where Self: UIViewController {
    var viewController: UIViewController {
        return self
    }
    
    var asNavigationController: UINavigationController {
        return self as? UINavigationController
        ?? UINavigationController(rootViewController: self)
    }
}

extension UIViewController: ViewControllable {}
