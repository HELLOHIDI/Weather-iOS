//
//  MockLoginUseCase.swift
//  MainFeatureTests
//
//  Created by 류희재 on 6/25/24.
//  Copyright © 2024 hellohidi. All rights reserved.
//

import RxSwift
import RxCocoa

import Domain
import Core

public final class MockMainUseCase: MainUseCase {
    public var weatherList = BehaviorRelay<[CurrentWeatherModel]>(value: [])
    
    public func updateSearchResult(_ text: String) -> Observable<[CurrentWeatherModel]> {
        return Observable.just([])
    }
    
    public func getCurrentWeatherData() -> Observable<[CurrentWeatherModel]> {
        return Observable.just([])
    }
}
