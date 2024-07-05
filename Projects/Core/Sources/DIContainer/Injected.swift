//
//  Injected.swift
//  Core
//
//  Created by 류희재 on 7/6/24.
//  Copyright © 2024 Weather-iOS. All rights reserved.
//

import Foundation

@propertyWrapper
public class Injected<T> {
    public let wrappedValue: T
    
    public init() {
        self.wrappedValue = DIContainer.shared.resolve()
    }
}
