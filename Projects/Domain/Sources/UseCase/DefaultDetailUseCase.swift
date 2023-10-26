//
//  DefaultDetailUseCase.swift
//  Domain
//
//  Created by 류희재 on 2023/10/25.
//  Copyright © 2023 hellohidi. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

public final class DefaultDetailUseCase: DetailUseCase {
    public var weatherList = BehaviorRelay<[WeatherModel]>(value: [])
    public var targetContentOffset = BehaviorRelay<CGPoint>(value: CGPoint())
    public var currentPage = BehaviorRelay<Int>(value: Int())
    public var weatherIndicatorList = BehaviorRelay<[WeatherIndicatorModel]>(value: [])
    
    
    public init(_ currentPage: Int, _ weatherList: [WeatherModel]) {
        self.currentPage.accept(currentPage)
        self.weatherList.accept(weatherList)
    }
    
    public func updateIndicatorView(_ updatePage: Int? = nil) {
        if let updatePage {
            self.currentPage.accept(updatePage)
        }
        let updateIndicatorList: [WeatherIndicatorModel] = (0..<weatherList.value.count).map { index in
            let isSelected = index == currentPage.value
            return WeatherIndicatorModel(isSelected: isSelected)
        }
        weatherIndicatorList.accept(updateIndicatorList)
    }
}
