//
//  PhotoSearchResponse.swift
//  Access-API-Sample
//
//  Created by kawaharadai on 2018/06/16.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import Foundation

struct PhotoSearchResponse: Codable {
    let stat: String
    let photos: Photos
}

struct Photos: Codable {
    let page: Int
    let pages: Int
    let perpage: Int
    var photo: [Photo]
}

struct Photo: Codable {
    let photoId: String
    let server: String
    let secret: String
    let farm: Int
    
    private enum CodingKeys: String, CodingKey {
        case photoId = "id"
        case server = "server"
        case secret = "secret"
        case farm = "farm"
    }
}

