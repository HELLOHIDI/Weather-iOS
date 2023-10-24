//
//  MainViewModel.swift
//  MainFeature
//
//  Created by 류희재 on 2023/10/24.
//  Copyright © 2023 hellohidi. All rights reserved.
//

import Domain

import RxSwift
import RxCocoa

public final class MainViewModel {
    internal var disposeBag = DisposeBag()
    public let mainUseCase: MainUseCase
    
    public init(mainUseCase: MainUseCase) {
        self.mainUseCase = mainUseCase
    }
    
    struct Input {
        
    }
    
    struct Output {
        public var weatherList = BehaviorRelay<[WeatherModel]>(value: WeatherModel.weatherData)
    }
    
    func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        self.bindOutput(output: output, disposeBag: disposeBag)
        
        return output
    }
    
    
    private func bindOutput(output: Output, disposeBag: DisposeBag) {
        mainUseCase.weatherList.subscribe(onNext: { weatherList in
            output.weatherList.accept(weatherList)
        }).disposed(by: disposeBag)
    }
}


