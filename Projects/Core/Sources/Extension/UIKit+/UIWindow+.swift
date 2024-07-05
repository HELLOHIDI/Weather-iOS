//
//  UIWindow+.swift
//  Core
//
//  Created by 류희재 on 7/6/24.
//  Copyright © 2024 Weather-iOS. All rights reserved.
//

import UIKit

public extension UIWindow {
    /// 현재 활성화된 키 윈도우를 반환한다
    static var keyWindowGetter: UIWindow? {
        if #available(iOS 13, *) {
            return (UIApplication.shared.connectedScenes
                        .compactMap { $0 as? UIWindowScene }
                        .flatMap { $0.windows }
                        .first { $0.isKeyWindow })
        } else {
            return UIApplication.shared.keyWindow
        }
    }
    
    /// 현재 키 윈도우의 루트 내비게이션 컨트롤러를 얻거나,
    /// 없을 경우 기본 내비게이션 컨트롤러를 제공하기 위해 사용됩니다.
    static var getRootNavigationController: UINavigationController {
        return keyWindowGetter?.rootViewController as? UINavigationController ?? UINavigationController(
            rootViewController: UIViewController()
        )
    }
}
