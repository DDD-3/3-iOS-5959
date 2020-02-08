//
//  StaticTableVC.swift
//  iOS5959
//
//  Created by mong on 2020/01/07.
//  Copyright © 2020 5959. All rights reserved.
//

import Foundation
import UIKit

class StaticTableVC: UITableViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var itemTitleTextField: UITextField!
    @IBOutlet var itemPriceTextField: UITextField!
    @IBOutlet var slider: UISlider!
    @IBOutlet var itemImageSelectBtn: UIButton!
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let roundedValue = round((sender.value/4) * 4)
        sender.value = roundedValue
        if sender.value == 0 {
            sender.setMinimumTrackImage(UIImage(), for: .normal)
        }else {
            sender.setMinimumTrackImage(UIImage(named: "SliderBackground_Fill"), for: .normal)
        }
    }
    @IBAction func imageSelectBtn(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "카메라로 촬영", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .camera)
        }))
        alert.addAction(UIAlertAction(title: "앨범에서 선택", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "닫기", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
        slider.setMinimumTrackImage(UIImage(), for: .normal)
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
    
    func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {

            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = sourceType
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            itemImageSelectBtn.setImage(image, for: .normal)
        }
        dismiss(animated: true, completion: nil)
    }
}
