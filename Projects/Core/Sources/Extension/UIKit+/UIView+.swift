//
//  UIView+.swift
//  Core
//
//  Created by 류희재 on 2023/10/20.
//  Copyright © 2023 baegteun. All rights reserved.
//

import UIKit

extension UIView {
    
    public func addSubviews (_ views: UIView...){
        views.forEach { self.addSubview($0) }
    }
    
    func makeShadow (
        color: UIColor,
        offset : CGSize,
        radius : CGFloat,
        opacity : Float)
    {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
    }
    
    public func makeCornerRound (radius: CGFloat){
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
    func makeCornerRound (ratio : CGFloat) {
        layer.cornerRadius = self.frame.height / ratio
        layer.masksToBounds = true
        clipsToBounds = true
    }
    
    public func setBorder(borderWidth: CGFloat, borderColor: UIColor) {
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
    }
    
//    func showToast(_ message: String,
//                   type: Toast.ToastType,
//                   view: UIView? = UIApplication.shared.firstWindow,
//                   bottomInset: CGFloat = 86) {
//        guard let view else { return }
//        Toast().show(message: message,
//                     type: type,
//                     view: view,
//                     bottomInset: bottomInset)
//    }
}


