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
    
    @IBOutlet var keyboardExtensionViewTextField: UITextField!
    @IBOutlet var keyboardExtensionView: UIView!
    @IBOutlet var keyboardExtensionViewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet var newItemImage: UIImageView!
    @IBOutlet var newItemLabel: UILabel!
    @IBOutlet var slider: UISlider!
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let roundedValue = round((sender.value/5) * 5)
            sender.value = roundedValue
        print(roundedValue)
        // base size = 64/64
        let imageSize: CGFloat = CGFloat(64 * (roundedValue + 1))
        newItemImage.frame = CGRect(x: UIScreen.main.bounds.midX - CGFloat(imageSize/2), y: UIScreen.main.bounds.midY - 150 - CGFloat(imageSize/2), width: imageSize, height: imageSize)
        newItemLabel.frame = CGRect(x: newItemImage.frame.midX - imageSize/2, y: newItemImage.frame.midY - 17/2, width: imageSize, height: 17)
    }
    @IBAction func didTextEditing(_ sender: UITextField) {
        newItemLabel.text = sender.text
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
            var tap = UITapGestureRecognizer(target: self, action: #selector(didTapGestureOnScreen(_:)))
            tap.delegate = self
            self.view.addGestureRecognizer(tap)
            
            // UIToolBar
            let numberToolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 56))
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

            keyboardExtensionViewTextField.inputAccessoryView = numberToolbar
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
