//
//  ItemDetailVC.swift
//  iOS5959
//
//  Created by mong on 2020/01/05.
//  Copyright © 2020 5959. All rights reserved.
//

import Foundation
import UIKit

class ItemDetailVC: UIViewController {
    var newItemTitle: String?
    var newItemPrice: String?
    
    @IBOutlet var confirmBtn: UIButton!
    @IBOutlet var confirmExtensionView: UIView!
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        
    }
    override func viewDidAppear(_ animated: Bool) {
    }
}
