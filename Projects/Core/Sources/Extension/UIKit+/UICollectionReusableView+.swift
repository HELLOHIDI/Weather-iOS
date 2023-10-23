//
//  UICollectionReusableView+.swift
//  Core
//
//  Created by 류희재 on 2023/10/20.
//  Copyright © 2023 baegteun. All rights reserved.
//

import UIKit

extension UICollectionReusableView{
    static var reuseCellIdentifier: String {
        return String(describing: self)
    }
}
