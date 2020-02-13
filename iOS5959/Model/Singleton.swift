//
//  Singleton.swift
//  iOS5959
//
//  Created by 최혜선 on 2020/02/12.
//  Copyright © 2020 5959. All rights reserved.
//

import Foundation

class Singleton {
    
    /// 콜렉션 리스트
    var collectionList: [CollectionItem] = []
    
    /// 현재 선택한 콜렉션
    var currentCollection: CollectionItem?
    
    static let shared = Singleton()
    
    private init() {
        
    }
}
