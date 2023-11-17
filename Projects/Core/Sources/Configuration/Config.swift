//
//  Config.swift
//  Core
//
//  Created by 류희재 on 2023/11/17.
//  Copyright © 2023 hellohidi. All rights reserved.
//

import Foundation

import Foundation

public enum Config {
    public enum Keys {
        public enum Plist {
            public static let baseURL = "BASE_URL"
            public static let apiKey = "API_KEY"
        }
    }
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("plist cannot found.")
        }
        return dict
    }()
}
