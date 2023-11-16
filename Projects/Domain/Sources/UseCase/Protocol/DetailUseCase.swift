//
//  DetailUseCase.swift
//  Domain
//
//  Created by 류희재 on 2023/10/25.
//  Copyright © 2023 hellohidi. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

public protocol DetailUseCase {
    var city: String { get }
    var currentWeatherData: PublishRelay<CurrentWeatherModel> { get }
    var hourlyWeatherData: PublishRelay<[HourlyWeatherModel]> { get }
    
    func getCurrentWeatherData()
    func getHourlyWeatherData()
}

