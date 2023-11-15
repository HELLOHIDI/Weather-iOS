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
    
    public func getCityWeatherData(tag: Int, city: String) -> Observable<CurrentWeatherModel> {
        return urlSessionService.get(
            url: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\("7618d35ff394f5dd39212928a3a4692f")",
            headers: ["Content-Type": "application/json"]
        ).map({ result in
            switch result {
            case .success(let data):
                guard let dto = self.decode(data: data, to: CurrentWeatherEntity.self) else { throw Error.responseDecodingError }
                return dto.toDomain(of: tag)
            case .failure(let error):
                throw error
            }
        })
    }
        
    
    
    private func decode<T: Decodable>(data: Data, to target: T.Type) -> T? {
        return try? JSONDecoder().decode(target, from: data)
    }
    
    
}

