//
//  MainBuilder.swift
//  MainFeatureInterface
//
//  Created by 류희재 on 7/5/24.
//  Copyright © 2024 Weather-iOS. All rights reserved.
//

import Core
import Domain

import MainFeatureInterface

public
final class MainBuilder {
    public var repository: WeatherRepository
    
    public init(repository: WeatherRepository) {
        self.repository = repository
    }
}

extension MainBuilder: MainFeatureViewBuildable {
    public func makeMain() -> MainPresentable {
        let useCase = DefaultMainUseCase(repository: repository)
        let vm = MainViewModel(mainUseCase: useCase)
        let vc = MainViewController(viewModel: vm)
        vc.viewModel = vm
        return (vc, vm)
    }
}
