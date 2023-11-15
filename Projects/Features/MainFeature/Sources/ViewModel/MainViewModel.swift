//
//  MainViewModel.swift
//  MainFeature
//
//  Created by 류희재 on 2023/10/24.
//  Copyright © 2023 hellohidi. All rights reserved.
//

import Foundation

import Domain

import RxSwift
import RxCocoa

public final class MainViewModel {
    internal var disposeBag = DisposeBag()
    
    public let mainCoordinator: MainCoordinator?
    public let mainUseCase: MainUseCase
    
    public init(mainCoordinator: MainCoordinator ,mainUseCase: MainUseCase) {
        self.mainCoordinator = mainCoordinator
        self.mainUseCase = mainUseCase
    }
    
    struct Input {
        let viewWillAppearEvent: Observable<Void>
        let weatherListViewDidTapEvent: Observable<IndexPath>
        let searchBarDidChangeEvent: Observable<String>
    }
    
    struct Output {
        public var weatherList = BehaviorRelay<[CurrentWeatherModel]>(value: [])
    }
    
    func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        self.bindOutput(output: output, disposeBag: disposeBag)
        
        input.viewWillAppearEvent.subscribe(with: self, onNext: { owner, _ in
            owner.mainUseCase.getCurrentWeatherData()
        }).disposed(by: disposeBag)
        
        input.weatherListViewDidTapEvent.subscribe(with: self, onNext: { owner, page in
            owner.mainCoordinator?.pushToDetailVC(with: page.item)
        }).disposed(by: disposeBag)
        
        input.searchBarDidChangeEvent.subscribe(with: self, onNext: { owner, text in
            owner.mainUseCase.updateSearchResult(text)
        }).disposed(by: disposeBag)
        return output
    }
    
    
    private func bindOutput(output: Output, disposeBag: DisposeBag) {
        mainUseCase.weatherList.subscribe(onNext: { weatherList in
            output.weatherList.accept(weatherList)
        }).disposed(by: disposeBag)
    }
}

public extension MainViewModel {
    func getWeatherList() -> [CurrentWeatherModel] {
        return mainUseCase.weatherList.value
    }
}

