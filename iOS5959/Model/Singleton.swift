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
    
    func getCurrentCollection(collectionId id: Int) -> CollectionItem? {
        return collectionList.filter { $0.collectionID == id }.first
    }
    
    /// 사용자 기본 콜렉션
    var defaultCollection: CollectionItem? {
        return collectionList.filter { $0.collectionType == CollectionType.defaultType }.first
    }
    
    static let shared = Singleton()
    
    private init() {
        
    }
}
