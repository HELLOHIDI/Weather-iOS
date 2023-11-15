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
    public let time, place, weather: String
    public let temparature, maxTemparature, minTemparature: Double
    
    public init(
        tag: Int,
        time: String,
        place: String,
        weather: String,
        temparature: Double,
        maxTemparature: Double,
        minTemparature: Double
    ) {
        self.tag = tag
        self.time = time
        self.place = place
        self.weather = weather
        self.temparature = temparature
        self.maxTemparature = maxTemparature
        self.minTemparature = minTemparature
    }
}
