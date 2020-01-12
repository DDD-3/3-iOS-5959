//
//  ItemMainVC.swift
//  iOS5959
//
//  Created by mong on 2019/12/21.
//  Copyright © 2019 5959. All rights reserved.
//

import Foundation
import UIKit

class ItemMainVC: UIViewController, UIGestureRecognizerDelegate {
    var numberToolbar: UIToolbar!
    var inputState = itemInputState.title
    @IBOutlet var openDetailVCBtn: UIButton!
    @IBOutlet var keyboardExtensionViewTextField: UITextField!
    @IBOutlet var keyboardExtensionView: UIView!
    @IBOutlet var keyboardExtensionViewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet var textFieldReturnBtn: UIButton!
    @IBOutlet var newItemImage: UIImageView!
    @IBOutlet var newItemTitleLabel: UILabel!
    @IBOutlet var newItemPriceLabel: UILabel!
    @IBOutlet var slider: UISlider!
    
    @IBOutlet var newItemHeightConstraint: NSLayoutConstraint!
    @IBOutlet var newItemWidthConstraint: NSLayoutConstraint!
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let roundedValue = round((sender.value/4) * 4)
            sender.value = roundedValue
        // minSize = 64/64, maxSize = 128/128
        newItemHeightConstraint.constant = CGFloat(64 + 64 * roundedValue/2)
        newItemWidthConstraint.constant = CGFloat(64 + 64 * roundedValue/2)
    }
    @IBAction func didTextEditing(_ sender: UITextField) {
        textFieldReturnBtn.isEnabled = true
        switch inputState {
        case .title:
            newItemTitleLabel.text = sender.text
        case .price:
            newItemPriceLabel.text = sender.text
        case .reason:
            break
        default:
            break
        }

    }
    @IBAction func textFieldReturnBtn(_ sender: Any) {
//        switch inputState {
//        case .title:

//        case .price:

//        case .reason:
//            numberToolbar.items![5].tintColor = UIColor.customColor(.coralRed)

        textFieldReturnBtn.isEnabled = false
        keyboardExtensionViewTextField.text = ""
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
            if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardRectangle = keyboardFrame.cgRectValue
                
                // 이거 그냥 keyboard.heigth로 주면 공백이 생기는데 왜그러지 ..?
                keyboardExtensionViewBottomConstraint.constant = -keyboardRectangle.height
                                
                UIView.animate(withDuration: 0, animations: {
                    self.view.layoutIfNeeded()
                    }, completion: { (completion) in
                       
                })
            }
        }
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
    
            keyboardExtensionViewBottomConstraint.constant = 0
            
            UIView.animate(withDuration: 0, animations: {
                self.view.layoutIfNeeded()
                }, completion: { (completion) in
            })
        }
    }
    @objc func didTapGestureOnScreen(_ sender: UITapGestureRecognizer?){
        keyboardExtensionViewTextField.resignFirstResponder()
    }
    override func viewDidLoad() {
        slider.setMinimumTrackImage(UIImage(named: "SliderBackground_Fill"), for: .normal)
        slider.setMaximumTrackImage(UIImage(named: "SliderBackground"), for: .normal)
        slider.setThumbImage(UIImage(named: "SliderThumb"), for: .normal)
        textFieldReturnBtn.isEnabled = false
        let swipeUpGesture: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeUpBtn))
        swipeUpGesture.direction = .up
        swipeUpGesture.delegate = self
        self.openDetailVCBtn.addGestureRecognizer(swipeUpGesture)
            
        var tap = UITapGestureRecognizer(target: self, action: #selector(didTapGestureOnScreen(_:)))
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
            
        // UIToolBar
        numberToolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 56))
        numberToolbar.barStyle = .default
        
        let reasonBarButtonItem = UIBarButtonItem(title: "이유", style: .plain, target: self, action: #selector(didTouchReason))
        reasonBarButtonItem.tintColor = UIColor.darkGray
        
        let priceBarbuttonItem = UIBarButtonItem(title: "가격", style: .plain, target: self, action: #selector(didTouchPrice))
        priceBarbuttonItem.tintColor = UIColor.darkGray
        
        let titleBarButtonItem = UIBarButtonItem(title: "상품명", style: .plain, target: self, action: #selector(didTouchTitle))
        titleBarButtonItem.tintColor = UIColor.customColor(.coralRed)
        
        let fixedSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        let fixedSpace2 = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        fixedSpace.width = 70
        fixedSpace2.width = 75
        numberToolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            titleBarButtonItem,
            fixedSpace,
            priceBarbuttonItem,
            fixedSpace2,
            reasonBarButtonItem,
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        ]

        numberToolbar.barTintColor = UIColor(displayP3Red: 210/255, green: 210/255, blue: 210/255, alpha: 1)
        numberToolbar.sizeToFit()
        
        keyboardExtensionViewTextField.inputAccessoryView = numberToolbar
    }
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func swipeUpBtn(){
        print("swipeUP")
    }
    
    @objc func didTouchReason(){
        numberToolbar.items![5].tintColor = UIColor.customColor(.coralRed)
        numberToolbar.items![3].tintColor = UIColor.darkGray
        numberToolbar.items![1].tintColor = UIColor.darkGray
        keyboardExtensionViewTextField.keyboardType = .default
        inputState = .reason
        keyboardExtensionViewTextField.text = ""
        keyboardExtensionViewTextField.reloadInputViews()
    }
    @objc func didTouchPrice(){
        numberToolbar.items![5].tintColor = UIColor.darkGray
        numberToolbar.items![3].tintColor = UIColor.customColor(.coralRed)
        numberToolbar.items![1].tintColor = UIColor.darkGray
        keyboardExtensionViewTextField.keyboardType = .phonePad
        inputState = .price
        keyboardExtensionViewTextField.text = ""
        keyboardExtensionViewTextField.reloadInputViews()
    }
    @objc func didTouchTitle(){
        numberToolbar.items![5].tintColor = UIColor.darkGray
        numberToolbar.items![3].tintColor = UIColor.darkGray
        numberToolbar.items![1].tintColor = UIColor.customColor(.coralRed)
        keyboardExtensionViewTextField.keyboardType = .default
        inputState = .title
        keyboardExtensionViewTextField.text = ""
        keyboardExtensionViewTextField.reloadInputViews()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ItemDetailSegue"{
            let ItemDetailVC = segue.destination as! ItemDetailVC
            if !newItemTitleLabel.text!.isEmpty && (newItemTitleLabel.text != "이름입력"){
                ItemDetailVC.newItemTitle = newItemTitleLabel.text
            }
            if !newItemPriceLabel.text!.isEmpty && (newItemPriceLabel.text != "가격미정"){
                ItemDetailVC.newItemPrice = newItemPriceLabel.text
            }
        }
    }
}
