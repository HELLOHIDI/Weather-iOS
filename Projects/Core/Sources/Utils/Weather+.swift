//
//  Weather+.swift
//  Core
//
//  Created by 류희재 on 2023/11/16.
//  Copyright © 2023 hellohidi. All rights reserved.
//

import Foundation

final public class WeatherUtil {
    public static func makeTimeZoneToTime(timeZone: Int) -> String {
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(secondsFromGMT: timeZone)
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: today)
    }
    
    public static func makedtTextToTime(_ dtText: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = dateFormatter.date(from: dtText) else { return ""}
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH"
        let timeString = timeFormatter.string(from: date)
        return timeString
    }
    
    public static func weatherIconToUrl(_ icon: String) -> String {
        return "http://openweathermap.org/img/wn/\(icon).png"
    }
}

