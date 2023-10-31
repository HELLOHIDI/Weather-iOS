//
//  WeatherModel.swift
//  Domain
//
//  Created by 류희재 on 2023/10/24.
//  Copyright © 2023 hellohidi. All rights reserved.
//

import RxSwift
import RxCocoa

public struct WeatherModel {
    public let tag: Int
    public let place, weather: String
    public let temparature, maxTemparature, minTemparature: Int
    public let hourlyWeatherData: [WeatherHourlyModel]
}

public extension WeatherModel {
    static let weatherData: [WeatherModel] = [
        WeatherModel(
            tag: 0,
            place: "의정부시",
            weather: "흐림",
            temparature: 21,
            maxTemparature: 29,
            minTemparature: 18,
            hourlyWeatherData: WeatherHourlyModel.hourlyWeatherData
        ),
        WeatherModel(
            tag: 1,
            place: "석계역",
            weather: "밝음",
            temparature: 23,
            maxTemparature: 31,
            minTemparature: 25,
            hourlyWeatherData: WeatherHourlyModel.hourlyWeatherData
        ),
        WeatherModel(
            tag: 2,
            place: "제주도",
            weather: "눈",
            temparature: 21,
            maxTemparature: 18,
            minTemparature: 4,
            hourlyWeatherData: WeatherHourlyModel.hourlyWeatherData
        )
    ]
}

