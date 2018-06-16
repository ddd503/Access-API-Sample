//
//  PhotoSearchApi.swift
//  Access-API-Sample
//
//  Created by kawaharadai on 2018/06/16.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import Foundation

/// API通信の結果
enum PhotoSearchAPIStatus {
    case successLoad(PhotoSearchResponse)
    case offline
    case emptyData
    case error(Error)
}

/// レスポンスのバリデーションチェックステータス
enum ValidationCheckStatus {
    case isEmpty
    case isOver
    case isIrregular
}

/// API通信の結果通知プロトコル
protocol PhotoSearchAPIDelegate: class {
    func searchResult(result: PhotoSearchAPIStatus)
}

/**
 APIと通信しAPIステータスをコントローラーへ返す
 */
final class PhotoSearchApi {
    
    weak var photoSearchAPIDelegate: PhotoSearchAPIDelegate?
    
    func requestAPI(seachWord: String) {
        
        // 通信環境チェック
        if !ApiClient.onLineNetwork() {
            photoSearchAPIDelegate?.searchResult(result: .offline)
            return
        }
        
        // パラメータを用意
        let parameters = SearchParamsBuilder.create(searchWord: seachWord, page: 1)
        
        // パラメータを付与したリクエスト作成
        let router = UrlRequester.searchAPI(parameters)
        
        // APIを叩く
        ApiClient.request(router: router) { [weak self] result in
            switch result {
            case .success(let jsonData):
                do {
                    // Codableにてjsonをマッピング
                    let decoder = JSONDecoder()
                    let photoSearchResponse = try decoder.decode(PhotoSearchResponse.self, from: jsonData)

                    guard
                        let myClass = self,
                        myClass.validationCheck(response: photoSearchResponse) else {
                        return
                    }
                    // 成功
                    self?.photoSearchAPIDelegate?.searchResult(result: .successLoad(photoSearchResponse))
                    
                } catch let error {
                    // 失敗
                    self?.photoSearchAPIDelegate?.searchResult(result: .error(error))
                }
            case .failure(let error):
                self?.photoSearchAPIDelegate?.searchResult(result: .error(error))
            }
        }
    }
    
    /// 各種バリデーションチェック（必要に応じて追加）
    private func validationCheck(response: PhotoSearchResponse) -> Bool {
        if response.photos.photo.isEmpty {
            /// 取得件数が0の時
            self.photoSearchAPIDelegate?.searchResult(result: .emptyData)
            return false
        }
        return true
    }

}
