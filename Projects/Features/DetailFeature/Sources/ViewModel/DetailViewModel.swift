//
//  DetailViewModel.swift
//  DetailFeature
//
//  Created by 류희재 on 2023/10/25.
//  Copyright © 2023 hellohidi. All rights reserved.
//

import Foundation

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
        let viewWillAppearEvent: Observable<Void>
        let scrollEvent: Observable<Int>
    }
    
    struct Output {
        var myPlaceWeatherList = BehaviorRelay<[WeatherModel]>(value: [])
        var targetContentOffset = BehaviorRelay<CGPoint>(value: CGPoint())
        var weatherIndicatorList = BehaviorRelay<[WeatherIndicatorModel]>(value: [])
        var currentPage = BehaviorRelay<Int>(value: 0)
    }
    
    func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        self.bindOutput(output: output, disposeBag: disposeBag)
        
        input.viewWillAppearEvent.subscribe(with: self, onNext: { owner, _ in
            owner.detailUseCase.updateIndicatorView(nil)
        }).disposed(by: disposeBag)
        
        input.scrollEvent.subscribe(with: self, onNext: { owner, updatePage in
            owner.detailUseCase.updateIndicatorView(updatePage)
        }).disposed(by: disposeBag)
        
//        input.scrollEvent.subscribe(with: self, onNext: { owner, operand in
//            owner.detailUseCase.calculatePage(operand)
//        }).disposed(by: disposeBag)
        
        return output
    }
    
    
    private func bindOutput(output: Output, disposeBag: DisposeBag) {
        detailUseCase.weatherList.subscribe(onNext: { weatherdata in
            output.myPlaceWeatherList.accept(weatherdata)
        }).disposed(by: disposeBag)
        
        detailUseCase.targetContentOffset.subscribe(onNext: { targetContentOffset in
            output.targetContentOffset.accept(targetContentOffset)
        }).disposed(by: disposeBag)
        
        detailUseCase.weatherIndicatorList.subscribe(onNext: { indicatorList in
            output.weatherIndicatorList.accept(indicatorList)
        }).disposed(by: disposeBag)
        
        detailUseCase.currentPage.subscribe(onNext: { currentPage in
            output.currentPage.accept(currentPage)
        }).disposed(by: disposeBag)
    }
}

extension DetailViewModel {
    public func getTargetContentOffset() -> CGPoint {
        return detailUseCase.targetContentOffset.value
    }
    
    public func getCurrentPage() -> CGFloat {
        return CGFloat(detailUseCase.currentPage.value)
    }
}


