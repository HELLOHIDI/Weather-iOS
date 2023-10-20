//
//  UINavagationController+.swift
//  Core
//
//  Created by 류희재 on 2023/10/20.
//  Copyright © 2023 baegteun. All rights reserved.
//

import UIKit
extension UINavigationController{
    
    var previousViewController: UIViewController? {
        let count = self.viewControllers.count
        return count < 2 ? self : self.viewControllers[count - 2]
    }
}
