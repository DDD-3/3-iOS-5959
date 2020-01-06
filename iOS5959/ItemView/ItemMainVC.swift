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
    @IBOutlet var openDetailVCBtn: UIButton!
    @IBOutlet var keyboardExtensionViewTextField: UITextField!
    @IBOutlet var keyboardExtensionView: UIView!
    @IBOutlet var keyboardExtensionViewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet var textFieldReturnBtn: UIButton!
    @IBOutlet var newItemImage: UIImageView!
    @IBOutlet var newItemTitleLabel: UILabel!
    @IBOutlet var newItemPriceLabel: UILabel!
    @IBOutlet var slider: UISlider!
    
    @IBAction func openDetailVCBtn(_ sender: Any) {
        guard let ItemDetailVC = storyboard?.instantiateViewController(identifier: "ItemDetailVC") as? ItemDetailVC else {return}
        present(ItemDetailVC, animated: true, completion: nil)
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let roundedValue = round((sender.value/5) * 5)
            sender.value = roundedValue
        print(roundedValue)
        // base size = 64/64
        let imageSize: CGFloat = CGFloat(64 * (roundedValue + 1))
        newItemImage.frame = CGRect(x: UIScreen.main.bounds.midX - CGFloat(imageSize/2), y: UIScreen.main.bounds.midY - 150 - CGFloat(imageSize/2), width: imageSize, height: imageSize)
        newItemTitleLabel.frame = CGRect(x: newItemImage.frame.midX - imageSize/2, y: newItemImage.frame.midY - 17, width: imageSize, height: 17)
        newItemPriceLabel.frame = CGRect(x: newItemImage.frame.midX - imageSize/2, y: newItemImage.frame.midY - 17/3, width: imageSize, height: 17)
        
    }
    @IBAction func didTextEditing(_ sender: UITextField) {
        textFieldReturnBtn.isEnabled = true
//        if newItemTitleLabel.text!.isEmpty && newItemPriceLabel.text!.isEmpty{
//            newItemTitleLabel.text = sender.text
//        }else if !newItemTitleLabel.text!.isEmpty && newItemPriceLabel.text!.isEmpty{
//            newItemPriceLabel.text = sender.text
//        }else{
//
//        }
    }
    @IBAction func textFieldReturnBtn(_ sender: Any) {
        if newItemTitleLabel.text!.isEmpty && newItemPriceLabel.text!.isEmpty{
            newItemTitleLabel.text = keyboardExtensionViewTextField.text
            numberToolbar.items![3].isEnabled = true
        }else if !newItemTitleLabel.text!.isEmpty && newItemPriceLabel.text!.isEmpty{
            newItemPriceLabel.text = keyboardExtensionViewTextField.text
            numberToolbar.items![1].isEnabled = true
        }else{
//            numberToolbar.items![1].isEnabled = true
        }
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
        numberToolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "subTitle", style: .plain, target: self, action: #selector(didTouchSubTitle)),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "price", style: .plain, target: self, action: #selector(didTouchPrice)),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "title", style: .plain, target: self, action: #selector(didTouchTitle)),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        ]
        numberToolbar.barTintColor = UIColor(displayP3Red: 210/255, green: 210/255, blue: 210/255, alpha: 1)
        numberToolbar.sizeToFit()
        numberToolbar.items![1].isEnabled = false
        numberToolbar.items![3].isEnabled = false
        
        keyboardExtensionViewTextField.inputAccessoryView = numberToolbar
    }
    
    @objc func swipeUpBtn(){
        print("swipeUP")
    }
    
    @objc func didTouchSubTitle(){
        keyboardExtensionViewTextField.keyboardType = .default
        keyboardExtensionViewTextField.reloadInputViews()
    }
    @objc func didTouchPrice(){
        keyboardExtensionViewTextField.keyboardType = .decimalPad
        keyboardExtensionViewTextField.reloadInputViews()
    }
    @objc func didTouchTitle(){
        keyboardExtensionViewTextField.keyboardType = .default
        keyboardExtensionViewTextField.reloadInputViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
