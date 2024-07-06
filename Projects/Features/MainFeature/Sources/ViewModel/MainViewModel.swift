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
import MainFeatureInterface

public final class MainViewModel: MainViewModelType {
    internal var disposeBag = DisposeBag()
    
    public let mainUseCase: MainUseCase
    
    public init(mainUseCase: MainUseCase) {
        self.mainUseCase = mainUseCase
    }
    
    public struct Input {
        let viewWillAppearEvent: Observable<Void>
        let weatherListViewDidTapEvent: Observable<IndexPath>
        let searchBarDidChangeEvent: Observable<String>
    }
    
    public struct Output {
        public var weatherList = BehaviorRelay<[CurrentWeatherModel]>(value: [])
    }
    
    //MARK: - MainCoordinator
    
    public var onWeatherCellTap: (() -> Void)?
    
    public func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        
        input.viewWillAppearEvent
            .flatMap(mainUseCase.getCurrentWeatherData)
            .bind(to: output.weatherList)
            .disposed(by: disposeBag)
        
        input.weatherListViewDidTapEvent.subscribe(with: self, onNext: { owner, page in
            owner.onWeatherCellTap?()
        }).disposed(by: disposeBag)
        
        input.searchBarDidChangeEvent
            .flatMap(mainUseCase.updateSearchResult)
            .bind(to: output.weatherList)
            .disposed(by: disposeBag)
        
        return output
    }
}

