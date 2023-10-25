//
//  WeatherHourlyModel.swift
//  Domain
//
//  Created by 류희재 on 2023/10/25.
//  Copyright © 2023 hellohidi. All rights reserved.
//

import UIKit

import DSKit

public struct WeatherHourlyModel {
    public let time, temparature: String
    public let weatherImage: UIImage
}

public extension WeatherHourlyModel {
    static let hourlyWeatherData: [WeatherHourlyModel] = [
        WeatherHourlyModel(
            time: "Now",
            temparature: "21",
            weatherImage: DSKitAsset.cloudy.image
        ),
        WeatherHourlyModel(
            time: "Now",
            temparature: "21",
            weatherImage: DSKitAsset.cloudy.image
        ),
        WeatherHourlyModel(
            time: "Now",
            temparature: "21",
            weatherImage: DSKitAsset.cloudy.image
        ),

        WeatherHourlyModel(
            time: "Now",
            temparature: "21",
            weatherImage: DSKitAsset.cloudy.image
        ),

        WeatherHourlyModel(
            time: "Now",
            temparature: "21",
            weatherImage: DSKitAsset.cloudy.image
        ),

        WeatherHourlyModel(
            time: "Now",
            temparature: "21",
            weatherImage: DSKitAsset.cloudy.image
        ),

        WeatherHourlyModel(
            time: "Now",
            temparature: "21",
            weatherImage: DSKitAsset.cloudy.image
        ),

        WeatherHourlyModel(
            time: "Now",
            temparature: "21",
            weatherImage: DSKitAsset.cloudy.image
        ),

        WeatherHourlyModel(
            time: "Now",
            temparature: "21",
            weatherImage: DSKitAsset.cloudy.image
        ),

        WeatherHourlyModel(
            time: "Now",
            temparature: "21",
            weatherImage: DSKitAsset.cloudy.image
        ),

        WeatherHourlyModel(
            time: "Now",
            temparature: "21",
            weatherImage: DSKitAsset.cloudy.image
        )
    ]
}
