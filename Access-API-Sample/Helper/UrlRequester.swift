//
//  UrlRequester.swift
//  Access-API-Sample
//
//  Created by kawaharadai on 2018/06/16.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//
import Alamofire

enum UrlRequester: URLRequestConvertible {
    /// 検索API
    case searchAPI([String: Any])
    
    /// ベースURL（エンドポイント）
    static let baseURLString = "https://api.flickr.com/services/rest"
    
    /// URLRequest型で変数を返す（３つのプロパティをenumのタイプによってセットした状態で）
    func asURLRequest() throws -> URLRequest {
        
        let (method, endPoint, parameters): (HTTPMethod, String, [String: Any]) = {
            
            switch self {
            case .searchAPI(let params):
                return (.get, "", params)
            }
        }()
        
        if let url = URL(string: UrlRequester.baseURLString) {
            var urlRequest = URLRequest(url: url.appendingPathComponent(endPoint))
            urlRequest.httpMethod = method.rawValue
            return try Alamofire.URLEncoding.default.encode(urlRequest, with: parameters)
        } else {
            fatalError("urlがnilです。")
        }
    }
}
