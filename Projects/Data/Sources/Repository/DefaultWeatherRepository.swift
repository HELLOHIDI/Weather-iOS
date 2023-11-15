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
    
    public func getCityWeatherData(city: String) async throws -> CurrentWeatherModel {
        let data = try await urlSessionService.get(
            url: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\("")",
            headers: ["Content-Type": "application/json"]
        )
        guard let dto = self.decode(data: data, to: CurrentWeatherEntity.self) else {
            throw Error.responseDecodingError
        }
        return dto.toDomain()
    }
    
    
    private func decode<T: Decodable>(data: Data, to target: T.Type) -> T? {
        return try? JSONDecoder().decode(target, from: data)
    }
    
    
}

