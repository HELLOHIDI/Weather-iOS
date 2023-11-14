//
//  SectionModelType.swift
//  Core
//
//  Created by 류희재 on 2023/11/02.
//  Copyright © 2023 hellohidi. All rights reserved.
//

import Foundation
import RxDataSources

public struct SectionData<T> {
    public var items: [T]

    public init(items: [T]) {
        self.items = items
    }
}

extension SectionData: SectionModelType {
    public typealias Item = T

    public init(original: SectionData, items: [T]) {
        self = original
        self.items = items
    }
}
