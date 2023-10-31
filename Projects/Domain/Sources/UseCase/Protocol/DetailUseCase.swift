//
//  DetailUseCase.swift
//  Domain
//
//  Created by 류희재 on 2023/10/25.
//  Copyright © 2023 hellohidi. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa

public protocol DetailUseCase {
    var weatherList: BehaviorRelay<[WeatherModel]> { get }
    var weatherIndicatorList: BehaviorRelay<[WeatherIndicatorModel]> { get }
    var targetContentOffset: BehaviorRelay<CGPoint> { get }
    var currentPage: BehaviorRelay<Int> { get }
    
    func updateIndicatorView(_ updatePage: Int?)
//    func calculatePage(_ scrollOperand: (CGFloat, CGFloat))
}

