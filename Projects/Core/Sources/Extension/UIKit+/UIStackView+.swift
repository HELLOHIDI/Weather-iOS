//
//  UIStackView+.swift
//  Core
//
//  Created by 류희재 on 2023/10/20.
//  Copyright © 2023 baegteun. All rights reserved.
//

import UIKit

extension UIStackView{
    
    func addArrangedSubViews(_ views: UIView...){
        views.forEach {  self.addArrangedSubview($0) }
    }
    
    func removeAllArrangedSubviews() {
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
}


