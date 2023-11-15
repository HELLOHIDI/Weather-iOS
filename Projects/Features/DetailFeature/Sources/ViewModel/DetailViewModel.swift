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
    
    public let detailCoordinator: DetailCoordinator?
    public let detailUseCase: DetailUseCase
    
    public init(
        detailCoordinator: DetailCoordinator,
        detailUseCase: DetailUseCase
    ) {
        self.detailCoordinator = detailCoordinator
        self.detailUseCase = detailUseCase
    }
    
    struct Input {
        let listButtonDidTapEvent: Observable<Void>
        let pagingEvent: Observable<Int>
    }
    
    struct Output {
        var myPlaceWeatherList = BehaviorRelay<[CurrentWeatherModel]>(value: [])
        var currentPage = BehaviorRelay<Int>(value: 0)
    }
    
    func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        self.bindOutput(output: output, disposeBag: disposeBag)
        
        input.listButtonDidTapEvent.subscribe(with: self, onNext: { owner, _ in
            owner.detailCoordinator?.popViewController()
        }).disposed(by: disposeBag)
        
        input.pagingEvent.subscribe(with: self, onNext: { owner, page in
            owner.detailUseCase.updateCurrentPage(page)
        }).disposed(by: disposeBag)
        
        return output
    }
    
    
    private func bindOutput(output: Output, disposeBag: DisposeBag) {
        detailUseCase.weatherList.subscribe(onNext: { weatherdata in
            output.myPlaceWeatherList.accept(weatherdata)
        }).disposed(by: disposeBag)
        
        detailUseCase.currentPage.subscribe(onNext: { currentPage in
            output.currentPage.accept(currentPage)
        }).disposed(by: disposeBag)
    }
}

extension DetailViewModel {
    public func getWeatherData() -> [CurrentWeatherModel] {
        return detailUseCase.weatherList.value
    }
    
    public func getCurrentPage() -> Int {
        return detailUseCase.currentPage.value
    }
}


