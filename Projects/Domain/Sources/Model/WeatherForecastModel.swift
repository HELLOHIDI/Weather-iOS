//
//  WeatherForecastModel.swift
//  Domain
//
//  Created by 류희재 on 2023/11/01.
//  Copyright © 2023 hellohidi. All rights reserved.
//

import UIKit

import DSKit

public struct WeatherForecastModel {
    public let day: String
    public let weatherImg: UIImage
    public let rainfall: String?
    public let maxTemparature, minTemparature: Int
}

public extension WeatherForecastModel {
    static let weatherForecastData: [WeatherForecastModel] = [
        WeatherForecastModel(
            day: "오늘",
            weatherImg: UIImage(systemName: "cloud.sun.fill")!,
            rainfall: nil,
            maxTemparature: 15,
            minTemparature: 29
        ),
        WeatherForecastModel(
            day: "월",
            weatherImg: UIImage(systemName: "cloud.sun.fill")!,
            rainfall: "60%",
            maxTemparature: 18,
            minTemparature: 27
        ),
        WeatherForecastModel(
            day: "화",
            weatherImg: UIImage(systemName: "cloud.sun.fill")!,
            rainfall: "60%",
            maxTemparature: 20,
            minTemparature: 25
        ),
        WeatherForecastModel(
            day: "수",
            weatherImg: UIImage(systemName: "cloud.sun.fill")!,
            rainfall: "70%",
            maxTemparature: 17,
            minTemparature: 25
        ),
        WeatherForecastModel(
            day: "목",
            weatherImg: UIImage(systemName: "cloud.sun.fill")!,
            rainfall: "50%",
            maxTemparature: 17,
            minTemparature: 25
        ),
        WeatherForecastModel(
            day: "금",
            weatherImg: UIImage(systemName: "cloud.sun.fill")!,
            rainfall: nil,
            maxTemparature: 20,
            minTemparature: 26
        ),
        WeatherForecastModel(
            day: "토",
            weatherImg: UIImage(systemName: "cloud.sun.fill")!,
            rainfall: nil,
            maxTemparature: 18,
            minTemparature: 25
        ),
        WeatherForecastModel(
            day: "일",
            weatherImg: UIImage(systemName: "cloud.sun.fill")!,
            rainfall: "50%",
            maxTemparature: 13,
            minTemparature: 21
        ),
        WeatherForecastModel(
            day: "월",
            weatherImg: UIImage(systemName: "cloud.sun.fill")!,
            rainfall: "50%",
            maxTemparature: 12,
            minTemparature: 19
        ),
        WeatherForecastModel(
            day: "화",
            weatherImg: UIImage(systemName: "cloud.sun.fill")!,
            rainfall: nil,
            maxTemparature: 18,
            minTemparature: 25
        ),
        WeatherForecastModel(
            day: "수",
            weatherImg: UIImage(systemName: "cloud.sun.fill")!,
            rainfall: nil,
            maxTemparature: 18,
            minTemparature: 25
        )
    ]
}
