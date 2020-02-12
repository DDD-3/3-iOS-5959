//
//  Login.swift
//  iOS5959
//
//  Created by 최혜선 on 2020/02/11.
//  Copyright © 2020 5959. All rights reserved.
//

import Foundation

struct Login: Codable {
    let status: Int
    let message: String
    let data: Token
}

struct Token: Codable {
    let refreshToken, accessToken: String
}
