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
    var cityList: [String] { get }
    var weatherList: BehaviorRelay<[CurrentWeatherModel]> { get }
    var currentPage: BehaviorRelay<Int> { get }
    
    func updateCurrentPage(_ page: Int)
    func getCurrentWeatherData()
}

