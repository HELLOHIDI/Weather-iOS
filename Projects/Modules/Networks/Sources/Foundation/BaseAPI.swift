//
//  BaseAPI.swift
//  Networks
//
//  Created by 류희재 on 2023/11/17.
//  Copyright © 2023 hellohidi. All rights reserved.
//

import Foundation
import Core

public enum APIType {
    case weather
}

public protocol BaseAPI: URLSessionTargetType {
    static var apiType: APIType { get set }
}

extension BaseAPI {
    public var baseURL: String {
        let base = Config.baseURL
        guard URL(string: base) != nil else {
            fatalError("baseURL could not be configured")
        }
        switch Self.apiType {
        case .weather:
            break
        }
        return base
    }
    
    public var headers: [String: String]? {
        return HeaderType.json.value
    }
}


public enum HeaderType {
    case json
//    case jsonWithToken
//    case multipartWithToken
    
    public var value: [String: String] {
        switch self {
        case .json:
            return ["Content-Type": "application/json"]
//        case .jsonWithToken:
//            return ["Content-Type": "application/json",
//                    "Authorization": UserDefaultKeyList.Auth.appAccessToken ?? ""]
//        case .multipartWithToken:
//            return ["Content-Type": "multipart/form-data",
//                    "Authorization": UserDefaultKeyList.Auth.appAccessToken ?? ""]
        }
    }
}
