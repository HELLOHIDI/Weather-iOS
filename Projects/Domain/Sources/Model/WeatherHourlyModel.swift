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
            temparature: "21°",
            weatherImage: DSKitAsset.cloudy.image
        ),
        WeatherHourlyModel(
            time: "10시",
            temparature: "21°",
            weatherImage: DSKitAsset.cloudy.image
        ),
        WeatherHourlyModel(
            time: "11시",
            temparature: "21°",
            weatherImage: DSKitAsset.cloudy.image
        ),

        WeatherHourlyModel(
            time: "12시",
            temparature: "21°",
            weatherImage: DSKitAsset.cloudy.image
        ),

        WeatherHourlyModel(
            time: "13시",
            temparature: "21°",
            weatherImage: DSKitAsset.cloudy.image
        ),

        WeatherHourlyModel(
            time: "14시",
            temparature: "21",
            weatherImage: DSKitAsset.cloudy.image
        ),

        WeatherHourlyModel(
            time: "15시",
            temparature: "21°",
            weatherImage: DSKitAsset.cloudy.image
        ),

        WeatherHourlyModel(
            time: "16시",
            temparature: "21°",
            weatherImage: DSKitAsset.cloudy.image
        ),

        WeatherHourlyModel(
            time: "17시",
            temparature: "21°",
            weatherImage: DSKitAsset.cloudy.image
        ),

        WeatherHourlyModel(
            time: "18시",
            temparature: "21°",
            weatherImage: DSKitAsset.cloudy.image
        ),

        WeatherHourlyModel(
            time: "19시",
            temparature: "21°",
            weatherImage: DSKitAsset.cloudy.image
        )
    ]
}
