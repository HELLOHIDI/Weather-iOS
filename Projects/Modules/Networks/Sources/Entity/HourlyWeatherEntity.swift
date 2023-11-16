//
//  HourlyWeatherEntity.swift
//  Networks
//
//  Created by 류희재 on 2023/11/16.
//  Copyright © 2023 hellohidi. All rights reserved.
//

import Foundation

// MARK: - HourlyWeatherEntity

public struct HourlyWeatherEntity: Codable {
    let cod: String
    let message, cnt: Int
    public let list: [List]
    let city: City
}

// MARK: - City
struct City: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population, timezone, sunrise, sunset: Int
}

// MARK: - List
public struct List: Codable {
    public let dt: Int
    public let main: MainClass
    public let weather: [DetailWeather]
    let clouds: Clouds
    let wind: Wind
    let visibility: Int
    let pop: Double
    let sys: DetailSys
    public let dtTxt: String
    let rain, snow: Rain?

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, sys
        case dtTxt = "dt_txt"
        case rain, snow
    }
}


// MARK: - MainClass
public struct MainClass: Codable {
    public let temp, feelsLike, tempMin, tempMax: Double
    let pressure, seaLevel, grndLevel, humidity: Int
    let tempKf: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

// MARK: - Rain
struct Rain: Codable {
    let the3h: Double

    enum CodingKeys: String, CodingKey {
        case the3h = "3h"
    }
}

// MARK: - Sys
struct DetailSys: Codable {
    let pod: Pod
}

enum Pod: String, Codable {
    case d = "d"
    case n = "n"
}

// MARK: - Weather
public struct DetailWeather: Codable {
    let id: Int
    let main: MainEnum
    public let description, icon: String
}

enum MainEnum: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
    case snow = "Snow"
}
