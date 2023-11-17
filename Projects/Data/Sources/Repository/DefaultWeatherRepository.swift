//
//  DefaultWeatherRepository.swift
//  ProjectDescriptionHelpers
//
//  Created by 류희재 on 2023/11/14.
//

import Foundation

import RxSwift

import Domain
import Networks

public class DefaultWeatherRepository: WeatherRepository {
    
    typealias Error = URLSessionNetworkServiceError
    public let urlSessionService: URLSessionNetworkService
    private let disposeBag = DisposeBag()
    
    public init(urlSessionService: URLSessionNetworkService) {
        self.urlSessionService = urlSessionService
    }
    
    public func getCityWeatherData(city: String) -> Observable<CurrentWeatherModel> {
        return urlSessionService.request(target: WeatherAPI.getCurrentWeatherData(city: city))
            .map({ result in
            switch result {
            case .success(let data):
                guard let dto = self.decode(data: data, to: CurrentWeatherEntity.self) else { throw Error.responseDecodingError }
                return dto.toDomain()
            case .failure(let error):
                throw error
            }
        })
    }
    
    public func getHourlyWeatherData(city: String) -> Observable<[HourlyWeatherModel]> {
        return urlSessionService.request(target: WeatherAPI.getHourlyWeatherData(city: city)).map({ result in
            switch result {
            case .success(let data):
                guard let dto = self.decode(data: data, to: HourlyWeatherEntity.self) else { throw Error.responseDecodingError }
                return dto.toDomain()
            case .failure(let error):
                throw error
            }
        })
    }
        
    
    
    private func decode<T: Decodable>(data: Data, to target: T.Type) -> T? {
        return try? JSONDecoder().decode(target, from: data)
    }
    
    
}

