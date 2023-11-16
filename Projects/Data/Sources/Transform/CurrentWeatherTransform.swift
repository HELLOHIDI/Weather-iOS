//
//  transform.swift
//  ProjectDescriptionHelpers
//
//  Created by 류희재 on 2023/11/14.
//

import Foundation

import Core
import Networks
import Domain

extension CurrentWeatherEntity {
    public func toDomain() -> CurrentWeatherModel {
        return CurrentWeatherModel(
            time: WeatherUtil.makeTimeZoneToTime(timeZone: timezone),
            place: name,
            weather: weather[0].main,
            temparature: main.temp,
            maxTemparature: main.tempMax,
            minTemparature: main.tempMin
        )
    }
}
