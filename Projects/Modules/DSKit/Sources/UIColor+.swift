//
//  UIColor+.swift
//  DSKit
//
//  Created by 류희재 on 2023/10/20.
//  Copyright © 2023 baegteun. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(r: Int, g: Int, b: Int) {
        self.init(red: CGFloat(r)/255,green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: 1)
    }
}

//MARK: - Custom Color

extension UIColor{
    static var white: UIColor {
        return UIColor(r: 255, g: 255, b: 255)
    }
}
