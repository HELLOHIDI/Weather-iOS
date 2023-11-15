//
//  DefaultDetailUseCase.swift
//  Domain
//
//  Created by 류희재 on 2023/10/25.
//  Copyright © 2023 hellohidi. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

public final class DefaultDetailUseCase: DetailUseCase {
    
    public var currentWeatherData = PublishRelay<CurrentWeatherModel>()
    public var city: String
    
    public let repository: WeatherRepository
    private let disposeBag = DisposeBag()
    
    public init(city: String, repository: WeatherRepository) {
        self.city = city
        self.repository = repository
    }

    public func getCurrentWeatherData() {
        repository.getCityWeatherData(city: city)
            .subscribe(with: self, onNext: { owner, currentWeatherData in
                owner.currentWeatherData.accept(currentWeatherData)
        }).disposed(by: disposeBag)
    }
}
