//
//  PhotoSearchResponseTest.swift
//  Access-API-SampleTests
//
//  Created by kawaharadai on 2018/06/16.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import XCTest
@testable import Access_API_Sample

/**
 非同期でAPIからのレスポンス結果を受けるテスト、PhotoSearchApiTestと合わせて実行
 */
final class PhotoSearchResponseTest: PhotoSearchAPIDelegate {
    
    var result: PhotoSearchAPIStatus?
    var asyncExpectation: XCTestExpectation?
    
    func searchResult(result: PhotoSearchAPIStatus) {
        guard let expectation = asyncExpectation else {
            XCTFail("Delegate is nil")
            return
        }
        
        self.result = result
        /// 期待値通りに処理完了
        expectation.fulfill()
    }
}
