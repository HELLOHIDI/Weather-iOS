//
//  WeatherAPI.swift
//  Networks
//
//  Created by 류희재 on 2023/11/17.
//  Copyright © 2023 hellohidi. All rights reserved.
//

import Foundation
import Core

public enum WeatherAPI {
    case getCurrentWeatherData(city: String)
    case getHourlyWeatherData(city: String)
}

extension WeatherAPI: BaseAPI {    
    public static var apiType: APIType = .weather
    
    public var path: String {
        switch self {
        case .getCurrentWeatherData(let city):
            return "/weather?q=\(city)&appid=\(Config.apiKey)"
        case .getHourlyWeatherData(let city):
            return "/forecast?q=\(city)&appid=\(Config.apiKey)"
        }
    }
    
    public var method: String {
        switch self {
        case .getCurrentWeatherData:
            return HTTPMethod.get
        case .getHourlyWeatherData:
            return HTTPMethod.get
        }
    }
    
    public var body: Data? {
        switch self {
        case .getCurrentWeatherData:
            return nil
        case .getHourlyWeatherData:
            return nil
        }
    }
}
