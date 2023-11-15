//
//  DefaultMainUseCase.swift
//  Domain
//
//  Created by 류희재 on 2023/10/24.
//  Copyright © 2023 hellohidi. All rights reserved.
//

import RxSwift
import RxCocoa

public final class DefaultMainUseCase: MainUseCase {
    public var cityList = ["gongju", "gwangju", "gumi", "gunsan", "daegu", "daejeon", "mokpo", "busan", "seosan", "seoul", "sokcho", "suwon", "suncheon", "ulsan", "iksan", "jeonju", "jeju", "cheonan", "cheongju", "chuncheon"]
    
    public var weatherList = BehaviorRelay<[CurrentWeatherModel]>(value: [])
    
    public let repository: WeatherRepository
    private let disposeBag = DisposeBag()
    
    public init(repository: WeatherRepository) {
        self.repository = repository
    }
    
    public func updateSearchResult(_ text: String) {
        let defaultWeatherList: [CurrentWeatherModel] = []
        if text.isEmpty {
            weatherList.accept(defaultWeatherList)
        } else {
            let filteredList = defaultWeatherList.filter { $0.place.contains(text) }
            weatherList.accept(filteredList)
        }
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
