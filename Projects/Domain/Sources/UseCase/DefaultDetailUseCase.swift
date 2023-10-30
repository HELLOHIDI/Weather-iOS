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
    public var currentPage = BehaviorRelay<Int>(value: Int())
    
    public init(_ currentPage: Int, _ weatherList: [WeatherModel]) {
        self.currentPage.accept(currentPage)
        self.weatherList.accept(weatherList)
    }
    
    public func updateCurrentPage(_ page: Int) {
        currentPage.accept(page)
    }
}
