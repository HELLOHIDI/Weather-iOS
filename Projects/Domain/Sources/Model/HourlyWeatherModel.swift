//
//  WeatherHourlyModel.swift
//  Domain
//
//  Created by 류희재 on 2023/10/25.
//  Copyright © 2023 hellohidi. All rights reserved.
//

import UIKit

public struct HourlyWeatherModel {
    public let time, weatherImage: String
    public let temparature: Double
    
    public init(time: String, temparature: Double, weatherImage: String) {
        self.time = time
        self.temparature = temparature
        self.weatherImage = weatherImage
    }
}
