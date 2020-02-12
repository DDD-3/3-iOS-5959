//
//  SearchTableviewCell.swift
//  iOS5959
//
//  Created by mong on 2020/02/12.
//  Copyright © 2020 5959. All rights reserved.
//

import Foundation
import UIKit

class SearchTableViewCell: UITableViewCell {
    var detailURL: String?
    
    @IBOutlet var selectBtn: UIButton!
    @IBOutlet var itemImageView: UIImageView!
    @IBOutlet var itemTitleLabel: UILabel!
    @IBOutlet var itemPriceLabel: UILabel!
}
