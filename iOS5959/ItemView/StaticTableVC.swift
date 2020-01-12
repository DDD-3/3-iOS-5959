//
//  StaticTableVC.swift
//  iOS5959
//
//  Created by mong on 2020/01/07.
//  Copyright © 2020 5959. All rights reserved.
//

import Foundation
import UIKit

class StaticTableVC: UITableViewController, UITextFieldDelegate {
    @IBOutlet var itemTitleTextField: UITextField!
    @IBOutlet var itemPriceTextField: UITextField!
    @IBOutlet var slider: UISlider!
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let roundedValue = round((sender.value/4) * 4)
        sender.value = roundedValue
    }
    @IBAction func imageSelectBtn(_ sender: Any) {
        print("click!")
    }
    
    @IBAction func itemTitleTextFieldEditingChanged(_ sender: UITextField) {
        guard let ItemDetailVC = self.parent as? ItemDetailVC else{return}
        if sender.text!.isEmpty {
            ItemDetailVC.confirmBtn.isEnabled = false
            ItemDetailVC.confirmExtensionView.backgroundColor = UIColor.customColor(.secondaryCement)
        }else{
            ItemDetailVC.confirmBtn.isEnabled = true
            ItemDetailVC.confirmExtensionView.backgroundColor = UIColor.customColor(.primaryCoral)
        }
    }
    
    
    override func viewDidLoad() {
        
        slider.setMinimumTrackImage(UIImage(named: "SliderBackground_Fill"), for: .normal)
        slider.setMaximumTrackImage(UIImage(named: "SliderBackground"), for: .normal)
        slider.setThumbImage(UIImage(named: "SliderThumb"), for: .normal)
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
