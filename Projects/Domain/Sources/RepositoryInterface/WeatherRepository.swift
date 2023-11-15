//
//  WeatherRepository.swift
//  Domain
//
//  Created by 류희재 on 2023/11/14.
//  Copyright © 2023 hellohidi. All rights reserved.
//

import RxSwift

public protocol WeatherRepository {
    func getCityWeatherData(tag: Int, city: String) -> Observable<CurrentWeatherModel>
}
