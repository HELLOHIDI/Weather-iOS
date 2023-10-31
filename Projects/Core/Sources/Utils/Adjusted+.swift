//
//  Adjusted+.swift
//  Core
//
//  Created by 류희재 on 2023/10/26.
//  Copyright © 2023 hellohidi. All rights reserved.
//

import UIKit

public extension CGFloat {
    var adjusted: CGFloat {
        let ratio: CGFloat = UIScreen.main.bounds.width / 375
        let ratioH: CGFloat = UIScreen.main.bounds.height / 812
        return ratio <= ratioH ? self * ratio : self * ratioH
    }
}

public extension Int {
    var adjusted: CGFloat {
        let ratio: CGFloat = UIScreen.main.bounds.width / 375
        let ratioH: CGFloat = UIScreen.main.bounds.height / 812
        return ratio <= ratioH ? CGFloat(self) * ratio : CGFloat(self) * ratioH
    }
}

