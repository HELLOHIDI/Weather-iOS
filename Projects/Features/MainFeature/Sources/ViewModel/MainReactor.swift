//
//  MainReactor.swift
//  MainFeature
//
//  Created by 류희재 on 6/6/24.
//  Copyright © 2024 hellohidi. All rights reserved.
//

import Foundation

import Domain

import RxSwift
import ReactorKit

public class MainReactor: Reactor {
    
    //MARK: - Properties
    
    public let mainUseCase: MainUseCase
    
    public let initialState: State = State()
    
    public enum Action {
        case viewWillAppearEvent
        case searchBarDidChangeEvent(String)
    }
    
    public enum Mutation {
        case getCurrentWeatherData([CurrentWeatherModel])
        case updateSearchResult([CurrentWeatherModel])
    }
    
    public struct State {
        var weatherList: [CurrentWeatherModel] = []
    }
    
    init(mainUseCase: MainUseCase) {
        self.mainUseCase = mainUseCase
    }
}

extension MainReactor {
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewWillAppearEvent:
            return mainUseCase.getCurrentWeatherData()
                .map {Mutation.getCurrentWeatherData($0)}
        case .searchBarDidChangeEvent(let city):
            return mainUseCase.updateSearchResult(city)
                .map {Mutation.updateSearchResult($0)}
        }
    }
}

extension MainReactor {
    public func reduce(state: State, mutation: Mutation) -> State {
        var newstate = state
        switch mutation {
        case .getCurrentWeatherData(let weatherList), .updateSearchResult(let weatherList):
            newstate.weatherList = weatherList
        }
        return newstate
    }
}
