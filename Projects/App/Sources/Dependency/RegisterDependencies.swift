//
//  RegisterDependencies.swift
//  Weather-iOS
//
//  Created by 류희재 on 7/6/24.
//  Copyright © 2024 Weather-iOS. All rights reserved.
//

import Core

import Networks
import Data
import Domain


extension AppDelegate {
    var container: DIContainer {
        DIContainer.shared
    }
    
    func registerDependencies() {
        container.register(
            interface: WeatherRepository.self,
            implement: {
                DefaultWeatherRepository(urlSessionService: WeatherNetworkService())
            }
        )
    }
}

