//
//  StaticTableVC.swift
//  iOS5959
//
//  Created by mong on 2020/01/07.
//  Copyright © 2020 5959. All rights reserved.
//

import Foundation
import UIKit

class StaticTableVC: UITableViewController {
    @IBOutlet var itemTitleTextField: UITextField!
    @IBOutlet var itemPriceTextField: UITextField!
    
    @IBAction func imageSelectBtn(_ sender: Any) {
        print("click!")
    }
    override func viewDidLoad() {
    }
    override func viewDidAppear(_ animated: Bool) {
        if let ItemDetailVC = self.parent as? ItemDetailVC {
            if ItemDetailVC.newItemTitle != nil{
                itemTitleTextField.text = ItemDetailVC.newItemTitle
            }
            if ItemDetailVC.newItemPrice != nil{
                itemPriceTextField.text = ItemDetailVC.newItemPrice
            }
        }
    }
}
