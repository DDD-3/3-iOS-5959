//
//  ModifyCollectionView.swift
//  iOS5959
//
//  Created by 최혜선 on 2020/01/02.
//  Copyright © 2020 5959. All rights reserved.
//

import UIKit

protocol ModifyCollectionViewDelegate: class {
    func touchedBackgroundView()
}

class ModifyCollectionView: UIView {
    weak var delegate: ModifyCollectionViewDelegate?
    @IBOutlet fileprivate weak var baseView: UIView!
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var textfield: UITextField!
    @IBOutlet fileprivate weak var colorChipCollectionView: ColorChipCollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textfield.becomeFirstResponder()
        textfield.returnKeyType = .done
        textfield.font = UIFont.nanumRegularFont(ofSize: 13.0)
        titleLabel.font = UIFont.nanumBoldFont(ofSize: 17.0)
        baseView.clipsToBounds = true
        baseView.layer.masksToBounds = false
        baseView.layer.cornerRadius = 14.0
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if touch.view == self {
                delegate?.touchedBackgroundView()
            }
        }
        self.endEditing(true)
    }
}
