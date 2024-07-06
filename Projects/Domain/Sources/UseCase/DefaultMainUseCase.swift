//
//  DefaultMainUseCase.swift
//  Domain
//
//  Created by 류희재 on 2023/10/24.
//  Copyright © 2023 hellohidi. All rights reserved.
//
//

import RxSwift
import RxCocoa

import Core

public final class DefaultMainUseCase: MainUseCase {
    public var weatherList = BehaviorRelay<[CurrentWeatherModel]>(value: [])
    
    public let repository: WeatherRepository
    private let disposeBag = DisposeBag()
    
    public init(repository: WeatherRepository) {
        self.repository = repository
    }
    
    //    public func updateSearchResult(_ text: String) -> Observable<[CurrentWeatherModel]> {
    //        let defaultWeatherList: [CurrentWeatherModel] = []
    //        return Observable.just(
    //            defaultWeatherList.filter { $0.place.contains(text)}
    //        )
    
    public func updateSearchResult(_ text: String) -> Observable<[CurrentWeatherModel]> {
        let defaultWeatherList: [CurrentWeatherModel] = []
        if text.isEmpty {
            weatherList.accept(defaultWeatherList)
        } else {
            let filteredList = defaultWeatherList.filter { $0.place.contains(text) }
            weatherList.accept(filteredList)
        }
        return weatherList.asObservable()
    }
    
    
    //        let defaultWeatherList: [CurrentWeatherModel] = []
    //        if text.isEmpty {
    //            weatherList.accept(defaultWeatherList)
    //        } else {
    //            let filteredList = defaultWeatherList.filter { $0.place.contains(text) }
    //            weatherList.accept(filteredList)
    //        }
    
    
    public func getCurrentWeatherData() -> Observable<[CurrentWeatherModel]> {
        let currentCityWeatherList = City.cityList.map { city in
            return repository.getCityWeatherData(city: city)
        }
        return Observable.zip(currentCityWeatherList).compactMap { $0 }
    }
}



//import RxSwift
//import RxCocoa
//
//import Core
//
//public final class DefaultMainUseCase: MainUseCase {
//    public var weatherList = BehaviorRelay<[CurrentWeatherModel]>(value: [])
//
//    public let repository: WeatherRepository
//    private let disposeBag = DisposeBag()
//
//    public init(repository: WeatherRepository) {
//        self.repository = repository
//    }
//
//    public func updateSearchResult(_ text: String) {
//        let defaultWeatherList: [CurrentWeatherModel] = []
//        if text.isEmpty {
//            weatherList.accept(defaultWeatherList)
//        } else {
//            let filteredList = defaultWeatherList.filter { $0.place.contains(text) }
//            weatherList.accept(filteredList)
//        }
//    }
//
//    public func getCurrentWeatherData() {
//        let currentCityWeatherList = City.cityList.map { city in
//            return repository.getCityWeatherData(city: city)
//        }
//
//        Observable.zip(currentCityWeatherList)
//            .subscribe(onNext: { cityWeatherArray in
//                let updateCurrentWeatherList = cityWeatherArray.compactMap { $0 }
//                self.weatherList.accept(updateCurrentWeatherList)
//            })
//            .disposed(by: disposeBag)
//
//
//    }
//}
