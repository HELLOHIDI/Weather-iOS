//
//  DetailViewModel.swift
//  DetailFeature
//
//  Created by 류희재 on 2023/11/16.
//  Copyright © 2023 hellohidi. All rights reserved.
//

import Foundation

import Domain

import RxSwift
import RxCocoa
import BaseFeatureDependency
import DetailFeatureInterface

public final class DetailViewModel: DetailViewModelType {
    internal var disposeBag = DisposeBag()
    
    public let detailUseCase: DetailUseCase
    
    public init(
        detailUseCase: DetailUseCase
    ) {
        self.detailUseCase = detailUseCase
    }
    
    public struct Input {
        let viewWillAppearEvent: Observable<Void>
    }
    
    public struct Output {
        var currentWeatherData = PublishRelay<CurrentWeatherModel>()
        var hourlyWeatherData = PublishRelay<[HourlyWeatherModel]>()
    }
    
    public func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        self.bindOutput(output: output, disposeBag: disposeBag)
        
        input.viewWillAppearEvent.subscribe(with: self, onNext: { owner, _ in
            owner.detailUseCase.getCurrentWeatherData()
            owner.detailUseCase.getHourlyWeatherData()
        }).disposed(by: disposeBag)
        
        return output
    }
    
    
    private func bindOutput(output: Output, disposeBag: DisposeBag) {
        detailUseCase.currentWeatherData.subscribe(onNext: { weatherdata in
            output.currentWeatherData.accept(weatherdata)
        }).disposed(by: disposeBag)
        
        detailUseCase.hourlyWeatherData.subscribe(onNext: { weatherdata in
            output.hourlyWeatherData.accept(weatherdata)
        }).disposed(by: disposeBag)
    }
}
