//
//  DefaultURLSessionNetworkService.swift
//  Networks
//
//  Created by 류희재 on 2023/11/15.
//  Copyright © 2023 hellohidi. All rights reserved.
//

import Foundation

public final class DefaultURLSessionNetworkService {
    private enum HTTPMethod {
        static let get = "GET"
        static let post = "POST"
        static let patch = "PATCH"
        static let delete = "DELETE"
    }

    public func post<T: Codable>(
        _ data: T,
        url urlString: String,
        headers: [String: String]?
    ) async throws -> Data {
        return try await self.request(with: data, url: urlString, headers: headers, method: HTTPMethod.post)
    }

    public func patch<T: Codable>(
        _ data: T,
        url urlString: String,
        headers: [String: String]?
    ) async throws -> Data {
        return try await self.request(with: data, url: urlString, headers: headers, method: HTTPMethod.patch)
    }

    public func delete(
        url urlString: String,
        headers: [String: String]?
    ) async throws -> Data {
        return try await self.request(url: urlString, headers: headers, method: HTTPMethod.delete)
    }

    public func get(
        url urlString: String,
        headers: [String: String]?
    ) async throws -> Data {
        return try await self.request(url: urlString, headers: headers, method: HTTPMethod.get)
    }

    private func request(
        url urlString: String,
        headers: [String: String]? = nil,
        method: String
    ) async throws -> Data {
        guard let url = URL(string: urlString) else {
            throw URLSessionNetworkServiceError.invalidURLError
        }

        var request = createHTTPRequest(of: url, with: headers, httpMethod: method)

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLSessionNetworkServiceError.unknownError
        }

        guard 200...299 ~= httpResponse.statusCode else {
            throw configureHTTPError(errorCode: httpResponse.statusCode)
        }

        return data
    }

    private func request<T: Codable>(
        with bodyData: T,
        url urlString: String,
        headers: [String: String]? = nil,
        method: String
    ) async throws -> Data {
        guard let url = URL(string: urlString),
              let httpBody = createPostPayload(from: bodyData) else {
                  throw URLSessionNetworkServiceError.emptyDataError
              }

        var request = createHTTPRequest(of: url, with: headers, httpMethod: method, with: httpBody)

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLSessionNetworkServiceError.unknownError
        }

        guard 200...299 ~= httpResponse.statusCode else {
            throw configureHTTPError(errorCode: httpResponse.statusCode)
        }

        return data
    }

    private func createPostPayload<T: Codable>(from requestBody: T) -> Data? {
        if let data = requestBody as? Data {
            return data
        }
        return try? JSONEncoder().encode(requestBody)
    }

    private func configureHTTPError(errorCode: Int) -> Error {
        return URLSessionNetworkServiceError(rawValue: errorCode)
            ?? URLSessionNetworkServiceError.unknownError
    }

    private func createHTTPRequest(
        of url: URL,
        with headers: [String: String]?,
        httpMethod: String,
        with body: Data? = nil
    ) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        headers?.forEach { header in
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }
        if let body = body {
            request.httpBody = body
        }

        return request
    }
}
