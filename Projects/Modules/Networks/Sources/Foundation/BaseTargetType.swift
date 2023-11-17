//
//  URLSessionTargetType.swift
//  Networks
//
//  Created by 류희재 on 2023/11/17.
//  Copyright © 2023 hellohidi. All rights reserved.
//

import Foundation

public enum HTTPMethod {
    static let get = "GET"
    static let post = "POST"
    static let patch = "PATCH"
    static let delete = "DELETE"
}

public protocol URLSessionTargetType {
    var baseURL: String { get }
    var path: String { get }
    var method: String { get }
    var headers: [String: String]? { get }
    var body: Data? { get }
}

extension URLRequest {
    init(target: URLSessionTargetType) {
        let url = URL(string: target.baseURL + target.path)
        self.init(url: url!)
        httpMethod = target.method
        
        target.headers?.forEach { (key, value) in
            addValue(value, forHTTPHeaderField: key)
        }
        
        if let body = target.body {
            httpBody = body
        }
    }
}

