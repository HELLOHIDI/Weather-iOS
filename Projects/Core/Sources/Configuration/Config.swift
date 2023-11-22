//
//  Config.swift
//  Core
//
//  Created by 류희재 on 2023/11/17.
//  Copyright © 2023 hellohidi. All rights reserved.
//

import Foundation

import Foundation

import Foundation

public struct Config {
    public static let apiKey = Bundle.main.infoDictionary?["API_KEY"] as! String
    public static let baseURL = Bundle.main.infoDictionary?["BASE_URL"] as! String
}

