//
//  DetailBuilder.swift
//  DetailFeatureInterface
//
//  Created by 류희재 on 7/5/24.
//  Copyright © 2024 Weather-iOS. All rights reserved.
//

import Core
import Domain

import DetailFeatureInterface

public
final class DetailBuilder {
    public init() {}
}

extension DetailBuilder: DetailFeatureViewBuildable {
    public func makeDetail(with page: Int) -> DetailPresentable {
        let vc = DetailPageViewController(currentPage: page)
        return vc
    }
}

