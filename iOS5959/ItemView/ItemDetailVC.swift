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
    @IBAction func trashBtn(_ sender: Any) {
        let alert = UIAlertController(title: "상품삭제", message: "해당 상품을 삭제하시겠습니까?\n복구할 수 없습니다", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "아니오", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "예", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        
    }
    override func viewDidAppear(_ animated: Bool) {
    }
}
