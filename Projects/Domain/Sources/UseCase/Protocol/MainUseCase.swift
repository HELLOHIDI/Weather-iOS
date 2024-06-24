//
//  MainUseCase.swift
//  Domain
//
//  Created by 류희재 on 2023/10/24.
//  Copyright © 2023 hellohidi. All rights reserved.
//

import RxSwift
import RxCocoa

public protocol MainUseCase {
    func updateSearchResult(_ text: String) -> Observable<[CurrentWeatherModel]>
    func getCurrentWeatherData() -> Observable<[CurrentWeatherModel]>
}
