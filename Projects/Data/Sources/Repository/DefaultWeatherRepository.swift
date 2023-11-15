//
//  DefaultWeatherRepository.swift
//  ProjectDescriptionHelpers
//
//  Created by 류희재 on 2023/11/14.
//

import RxSwift

import Domain
import Networks

public class DefaultWeatherRepository: WeatherRepository {
    
    public let urlSessionService: URLSessionNetworkService
    private let disposeBag = DisposeBag()
    
    public init(urlSessionService: URLSessionNetworkService) {
        self.urlSessionService = urlSessionService
    }
    
    public func getCityWeatherData() {
        
    }
    
    
}

