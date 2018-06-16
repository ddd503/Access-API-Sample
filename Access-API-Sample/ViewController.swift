//
//  ViewController.swift
//  Access-API-Sample
//
//  Created by kawaharadai on 2018/06/16.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let photoSearchApi = PhotoSearchApi()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
        // 画像検索APIを叩く
        photoSearchApi.requestAPI(seachWord: "Sky")
    }
    
    private func setup() {
        photoSearchApi.photoSearchAPIDelegate = self
    }
    
}

// 通信結果を受ける
extension ViewController: PhotoSearchAPIDelegate {
    
    func searchResult(result: PhotoSearchAPIStatus) {
        // APIの返却ステータスによって処理を分岐
        switch result {
        case .successLoad(let response):
            print("成功時のレスポンス：\(response)")
        case .error(let error):
            print("エラー発生\(error)")
        case .emptyData:
            print("検索データが0です。")
        case .offline:
            print("オフラインのため通信できません。")
        }
    }
}
