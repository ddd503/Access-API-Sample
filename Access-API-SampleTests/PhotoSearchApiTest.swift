//
//  PhotoSearchApiTest.swift
//  Access-API-SampleTests
//
//  Created by kawaharadai on 2018/06/16.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import XCTest
@testable import Access_API_Sample
/**
 API通信して非同期処理で受け取ったレスポンスの種類によって処理を分岐するテスト
 */
final class PhotoSearchApiTest: XCTestCase {
    
    let photoSearchAPI = PhotoSearchApi()
    let delegateTest = PhotoSearchResponseTest()
    
    override func setUp() {
        super.setUp()
        photoSearchAPI.photoSearchAPIDelegate = delegateTest
    }
    
    override func tearDown() {
        super.tearDown()
        photoSearchAPI.photoSearchAPIDelegate = nil
    }
    
    func testRequestAPI() {
        let expectation = self.expectation(description: "sky")
        delegateTest.asyncExpectation = expectation
        
        photoSearchAPI.requestAPI(seachWord: "sky")
        
        waitForExpectations(timeout: 1.0) { error in
            if let error = error {
                XCTFail("タイムアウトエラー(1秒): \(error)")
            }
            
            if let result = self.delegateTest.result {
                
                switch result {
                case .successLoad(let result):
                    XCTAssertNotNil(result)
                    XCTAssertTrue(result.photos.photo.count > 0)
                case .error(let error):
                    XCTAssertNotNil(error)
                    XCTFail("エラー")
                case .emptyData:
                    XCTFail("データが0件")
                case .offline:
                    XCTAssertNotNil(result)
                    XCTFail("オフライン")
                }
            }
        }
    }
    
}
