//
//  DefaultURLSessionNetworkService.swift
//  Networks
//
//  Created by 류희재 on 2023/11/15.
//  Copyright © 2023 hellohidi. All rights reserved.
//

import Foundation

import RxSwift

public final class WeatherNetworkService: URLSessionNetworkService {
    
    public init () {}
    public func request(target: URLSessionTargetType) -> Observable<Result<Data, URLSessionNetworkServiceError>> {

        return Observable<Result<Data, URLSessionNetworkServiceError>>.create { emitter in
            let request = URLRequest(target: target)
            NetworkLogger.log(request: request)
            let task = URLSession.shared.dataTask(with: request) { data, reponse, error in
                NetworkLogger.log(response: reponse as? HTTPURLResponse, data: data, error: error)
                guard let httpResponse = reponse as? HTTPURLResponse else {
                    emitter.onError(URLSessionNetworkServiceError.unknownError)
                    return
                }

                if error != nil {
                    emitter.onError(self.configureHTTPError(errorCode: httpResponse.statusCode))
                    return
                }

                guard 200...299 ~= httpResponse.statusCode else {
                    emitter.onError(self.configureHTTPError(errorCode: httpResponse.statusCode))
                    return
                }
                guard let data = data else {
                    emitter.onNext(.failure(.emptyDataError))
                    return
                }
                emitter.onNext(.success(data))
                emitter.onCompleted()
            }
            task.resume()

            return Disposables.create {
                task.cancel()
            }
        }
    }
    
//    public func request<T: Codable>(
//        with bodyData: T,
//        target: URLSessionTargetType) -> Observable<Result<Data, URLSessionNetworkServiceError>> {
//        if let httpBody = self.createPostPayload(from: bodyData) {
//            return Observable.error(URLSessionNetworkServiceError.emptyDataError)
//        }
//        return Observable<Result<Data, URLSessionNetworkServiceError>>.create { emitter in
//            let request = URLRequest(target: target, with:)
//            NetworkLogger.log(request: request)
//            let task = URLSession.shared.dataTask(with: request) { data, reponse, error in
//                NetworkLogger.log(response: reponse as? HTTPURLResponse, data: data, error: error)
//                guard let httpResponse = reponse as? HTTPURLResponse else {
//                    emitter.onError(URLSessionNetworkServiceError.unknownError)
//                    return
//                }
//                
//                if error != nil {
//                    emitter.onError(self.configureHTTPError(errorCode: httpResponse.statusCode))
//                    return
//                }
//                
//                guard 200...299 ~= httpResponse.statusCode else {
//                    emitter.onError(self.configureHTTPError(errorCode: httpResponse.statusCode))
//                    return
//                }
//                guard let data = data else {
//                    emitter.onNext(.failure(.emptyDataError))
//                    return
//                }
//                emitter.onNext(.success(data))
//                emitter.onCompleted()
//            }
//            task.resume()
//            
//            return Disposables.create {
//                task.cancel()
//            }
//        }
//    }
    
//    private func request<T: Codable>(
//        with bodyData: T,
//        url urlString: String,
//        headers: [String: String]? = nil,
//        method: String
//    ) -> Observable<Result<Data, URLSessionNetworkServiceError>> {
//        guard let url = URL(string: urlString),
//              let httpBody = self.createPostPayload(from: bodyData) else {
//                  return Observable.error(URLSessionNetworkServiceError.emptyDataError)
//              }
//        return Observable<Result<Data, URLSessionNetworkServiceError>>.create { emitter in
//            let request = self.createHTTPRequest(of: url, with: headers, httpMethod: method, with: httpBody)
//            let task = URLSession.shared.dataTask(with: request) { data, reponse, error in
//                guard let httpResponse = reponse as? HTTPURLResponse else {
//                    emitter.onError(URLSessionNetworkServiceError.unknownError)
//                    return
//                }
//                if error != nil {
//                    emitter.onError(self.configureHTTPError(errorCode: httpResponse.statusCode))
//                    return
//                }
//                guard 200...299 ~= httpResponse.statusCode else {
//                    emitter.onError(self.configureHTTPError(errorCode: httpResponse.statusCode))
//                    return
//                }
//                guard let data = data else {
//                    emitter.onNext(.failure(.emptyDataError))
//                    return
//                }
//                emitter.onNext(.success(data))
//                emitter.onCompleted()
//            }
//            task.resume()
//
//            return Disposables.create {
//                task.cancel()
//            }
//        }
//    }
    
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
    
//    private func createHTTPRequest(
//        of url: URL,
//        with headers: [String: String]?,
//        httpMethod: String,
//        with body: Data? = nil
//    ) -> URLRequest {
//        var request = URLRequest(url: url)
//        request.httpMethod = httpMethod
//        headers?.forEach({ header in
//            request.addValue(header.value, forHTTPHeaderField: header.key)
//        })
//        if let body = body {
//            request.httpBody = body
//        }
//
//        return request
//    }
}
