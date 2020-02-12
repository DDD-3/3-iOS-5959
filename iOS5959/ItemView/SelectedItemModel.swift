//
//  SearchItemModel.swift
//  iOS5959
//
//  Created by mong on 2020/02/12.
//  Copyright © 2020 5959. All rights reserved.
//

import Foundation
import UIKit

struct SelectedItemModel {
    var selectedItemName: String?
    var selectedItemURL: String?
    var selectedItemImage: UIImage?
    var selectedItemPrice: String?
    
    init(name: String, detailUrl: String, image: UIImage, price: String) {
        self.selectedItemName = name
        self.selectedItemURL = detailUrl
        self.selectedItemImage = image
        self.selectedItemPrice = price
    }
}
