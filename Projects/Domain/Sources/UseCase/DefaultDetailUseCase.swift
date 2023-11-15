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
    public var weatherList = BehaviorRelay<[CurrentWeatherModel]>(value: [])
    public var currentPage = BehaviorRelay<Int>(value: Int())
    
    public var cityList = ["gongju", "gwangju", "gumi", "gunsan", "daegu", "daejeon", "mokpo", "busan", "seosan", "seoul", "sokcho", "suwon", "suncheon", "ulsan", "iksan", "jeonju", "jeju", "cheonan", "cheongju", "chuncheon"]
    
    public let repository: WeatherRepository
    private let disposeBag = DisposeBag()
    
    public init(repository: WeatherRepository, _ currentPage: Int) {
        self.currentPage.accept(currentPage)
        self.repository = repository
    }
    
    public func updateCurrentPage(_ page: Int) {
        currentPage.accept(page)
    }
    
    public func getCurrentWeatherData() {
        let currentCityWeatherList = cityList.enumerated().map { (index, city) in
            return repository.getCityWeatherData(tag: index, city: city)
        }
        
        Observable.zip(currentCityWeatherList)
            .subscribe(onNext: { cityWeatherArray in
                let updateCurrentWeatherList = cityWeatherArray.compactMap { $0 }
                self.weatherList.accept(updateCurrentWeatherList)
            })
            .disposed(by: disposeBag)
        
        
    }
}
