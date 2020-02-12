//
//  Collection.swift
//  iOS5959
//
//  Created by 최혜선 on 2020/02/12.
//  Copyright © 2020 5959. All rights reserved.
//

import Foundation

struct Collection: Codable {
    let status: Int
    let message: String
    let data: [CollectionItem]
}

struct CollectionItem: Codable {
    let collectionID: Int
    let collectionType, title, color: String

    enum CodingKeys: String, CodingKey {
        case collectionID = "collectionId"
        case collectionType, title, color
    }
}
