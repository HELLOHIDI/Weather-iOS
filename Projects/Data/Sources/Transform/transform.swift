//
//  transform.swift
//  ProjectDescriptionHelpers
//
//  Created by 류희재 on 2023/11/14.
//

import Foundation

import Networks
import Domain


extension CurrentWeatherEntity {
    public func toDomain(of tag: Int) -> CurrentWeatherModel {
        return CurrentWeatherModel(
            tag: tag,
            time: makeTimeZoneToTime(timeZone: timezone),
            place: name,
            weather: weather[0].main,
            temparature: main.temp,
            maxTemparature: main.tempMax,
            minTemparature: main.tempMin
        )
    }
    
    func makeTimeZoneToTime(timeZone: Int) -> String {
            let today = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone(secondsFromGMT: timeZone)
            dateFormatter.dateFormat = "HH:mm"
            return dateFormatter.string(from: today)
            
        }
}
