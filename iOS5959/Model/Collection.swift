//
//  Collection.swift
//  iOS5959
//
//  Created by 최혜선 on 2020/02/12.
//  Copyright © 2020 5959. All rights reserved.
//

import Foundation

enum CollectionType: String, Codable {
    case defaultType = "DEFAULT"
    case nonDefaultType = "NON_DEFAULT"
}

struct Collection: Codable {
    let status: Int
    let message: String
    let data: [CollectionItem]
}

struct CollectionItem: Codable {
    let collectionID: Int
    let collectionType: CollectionType
    let title, color: String

    enum CodingKeys: String, CodingKey {
        case collectionID = "collectionId"
        case collectionType, title, color
    }
}

struct AddCollection: Codable {
    let title: String
    let color: String
}

struct EditCollectionResponse: Codable {
    let status: Int
    let message: String
    let data: CollectionItem?
}
