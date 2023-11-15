//
//  WeatherModel.swift
//  Domain
//
//  Created by 류희재 on 2023/10/24.
//  Copyright © 2023 hellohidi. All rights reserved.
//

import RxSwift
import RxCocoa

public struct CurrentWeatherModel {
    public let tag: Int
    public let place, weather: String
    public let temparature, maxTemparature, minTemparature: Double
    
    public init(tag: Int, place: String, weather: String, temparature: Double, maxTemparature: Double, minTemparature: Double) {
        self.tag = tag
        self.place = place
        self.weather = weather
        self.temparature = temparature
        self.maxTemparature = maxTemparature
        self.minTemparature = minTemparature
    }
}

public extension CurrentWeatherModel {
    static let weatherData: [CurrentWeatherModel] = [
        //        CurrentWeatherModel(
        //            tag: 0,
        //            place: "의정부시",
        //            weather: "흐림",
        //            temparature: 21,
        //            maxTemparature: 29,
        //            minTemparature: 18
        //        ),
        //        CurrentWeatherModel(
        //            tag: 1,
        //            place: "석계역",
        //            weather: "밝음",
        //            temparature: 23,
        //            maxTemparature: 31,
        //            minTemparature: 25
        //        ),
        //        CurrentWeatherModel(
        //            tag: 2,
        //            place: "제주도",
        //            weather: "눈",
        //            temparature: 21,
        //            maxTemparature: 18,
        //            minTemparature: 4
        //        )
    ]
}

