//
//  Search.swift
//  iOS5959
//
//  Created by mong on 2020/02/12.
//  Copyright © 2020 5959. All rights reserved.
//

import Foundation

struct Search: Codable {
    let status: Int
    let message: String
    let data: searchResults
}

struct searchResults: Codable {
    let searchResults: [searchResult]
}

struct searchResult: Codable {
    let name: String
    let price: String
    let imageUrl: String
    let detailUrl: String
}
