//
//  UIImageView+.swift
//  Core
//
//  Created by 류희재 on 2023/10/20.
//  Copyright © 2023 baegteun. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView{
    func kfSetImage(url : String?, defaultImage: UIImage?){
        
        guard let url = url else {
            self.image = defaultImage
            return
        }
        
        if let url = URL(string: url) {
            kf.indicatorType = .activity
            kf.setImage(with: url,
                        placeholder: nil,
                        options: [.transition(.fade(1.0))], progressBlock: nil)
        }
    }
}

