//
//  HourlyWeatherTransform.swift
//  Data
//
//  Created by 류희재 on 2023/11/16.
//  Copyright © 2023 hellohidi. All rights reserved.
//

import Foundation

import Core
import Networks
import Domain

extension HourlyWeatherEntity {
    public func toDomain() -> [HourlyWeatherModel] {
        var hourlyWeatherData: [HourlyWeatherModel] = []
        for hourlyWeather in list {
            hourlyWeatherData.append(
                HourlyWeatherModel(
                    time: WeatherUtil.makedtTextToTime(hourlyWeather.dtTxt),
                    temparature: hourlyWeather.main.temp,
                    weatherImage: WeatherUtil.weatherIconToUrl(hourlyWeather.weather[0].icon)
                )
            )
        }
        return hourlyWeatherData
    }
}
