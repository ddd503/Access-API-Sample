//
//  ApiClient.swift
//  Access-API-Sample
//
//  Created by kawaharadai on 2018/06/16.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import Alamofire

/// API通信の結果
enum Result {
    case success(Data)
    case failure(Error)
}

final class ApiClient {
    
    static func request(router: UrlRequester,
                        completionHandler: @escaping (Result) -> Void = { _ in }) {
        
        Alamofire.request(router).responseData { response in
            
            let statusCode = response.response?.statusCode
            print("HTTP status code: \(String(describing: statusCode))")
            
            switch response.result {
                
            case .success(let value):
                completionHandler(Result.success(value))
                return
                
            case .failure:
                if let error = response.result.error {
                    completionHandler(Result.failure(error))
                    return
                }
            }
        }
    }
    
    /// 通信状態を返す
    ///
    /// - Returns: true: オンライン, false: オフライン
    static func onLineNetwork() -> Bool {
        if let reachabilityManager = NetworkReachabilityManager() {
            reachabilityManager.startListening()
            return reachabilityManager.isReachable
        }
        return false
    }
}

