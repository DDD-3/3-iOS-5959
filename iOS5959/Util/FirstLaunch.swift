//
//  FirstLaunch.swift
//  iOS5959
//
//  Created by 최혜선 on 2020/02/10.
//  Copyright © 2020 5959. All rights reserved.
//

import Foundation

protocol FirstLaunchDelegate: class {
    func firstLaunch()
}

class FirstLaunch {
    // check the app first launch after install
    private let key = "wasLaunched"
    // 이미 실행했으면 true 아니면 false
    private let wasLaunchedBefore: Bool
    var delegate: FirstLaunchDelegate?
    
    init() {
        wasLaunchedBefore = UserDefaults.standard.bool(forKey: key)
        
        if wasLaunchedBefore {
            print("앱 두번째 실행")
        } else {
            UserDefaults.standard.set(true, forKey: key)
            print("앱 처음 실행")
            delegate?.firstLaunch()
        }
    }
}
