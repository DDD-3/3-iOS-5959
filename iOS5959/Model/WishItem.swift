//
//  WishItem.swift
//  iOS5959
//
//  Created by 최혜선 on 2020/02/14.
//  Copyright © 2020 5959. All rights reserved.
//

import Foundation

/// 위시 다건 조회용 모델
struct Wish: Codable {
    let status: Int
    let message: String
    let data: [WishItems]?
}

struct WishItems: Codable {
    let collectionID: Int
    let collectionType, title, color: String
    let wishItems: [WishItem]

    enum CodingKeys: String, CodingKey {
        case collectionID = "collectionId"
        case collectionType, title, color, wishItems
    }
}

/// 위시아이템 모델
struct WishItem: Codable {
    let wishItemID, collectionID: Int
    let name: String
    let importance: Int
    let price: Int?
    let memo: String?
    let imageURL: String
    let purchasingURL: String?
    let recentModifiedDate: String

    enum CodingKeys: String, CodingKey {
        case wishItemID = "wishItemId"
        case collectionID = "collectionId"
        case name, importance, price, memo
        case imageURL = "imageUrl"
        case purchasingURL = "purchasingUrl"
        case recentModifiedDate
    }
}

/// 위시아이템 단건 조회
struct OneWishItem: Codable {
    let status: Int
    let message: String
    let data: WishItem
}

/// 위시아이템 등록
struct AddWishItem: Codable {
    let targetCollectionId: Int
    let name: String
    let importance: Int
    let price: String
    let memo: String
    let purchasingUrl: String
    let imageFile: Data
}
