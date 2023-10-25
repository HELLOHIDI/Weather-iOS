//
//  DetailViewModel.swift
//  DetailFeature
//
//  Created by 류희재 on 2023/10/25.
//  Copyright © 2023 hellohidi. All rights reserved.
//

import Domain

import RxSwift
import RxCocoa

public final class DetailViewModel {
    internal var disposeBag = DisposeBag()
    public let detailUseCase: DetailUseCase
    
    public init(detailUseCase: DetailUseCase) {
        self.detailUseCase = detailUseCase
    }
    
    struct Input {
        
    }
    
    struct Output {
        public var hourlyWeatherList = BehaviorRelay<[WeatherHourlyModel]>(value: WeatherHourlyModel.hourlyWeatherData)
    }
    
    func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        self.bindOutput(output: output, disposeBag: disposeBag)
        
        return output
    }
    
    
    private func bindOutput(output: Output, disposeBag: DisposeBag) {
        detailUseCase.hourlyWeatherList.subscribe(onNext: { weatherList in
            output.hourlyWeatherList.accept(weatherList)
        }).disposed(by: disposeBag)
    }
}



