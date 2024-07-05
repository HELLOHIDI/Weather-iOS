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
    @Injected public var repository: WeatherRepository
    
    public init() {}
}

extension DetailBuilder: DetailFeatureViewBuildable {
    public func makeDetail() -> DetailPresentable {
        let useCase = DefaultDetailUseCase(city: "", repository: repository)
        let vm = DetailViewModel(detailUseCase: useCase)
        let vc = DetailViewController(viewModel: vm)
        vc.viewModel = vm
        return (vc, vm)
    }
}

