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
    var editMode: EditMode = .create
    weak var delegate: ModifyCollectionViewDelegate?
    @IBOutlet fileprivate weak var baseView: UIView!
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var textfield: UITextField!
    @IBOutlet fileprivate weak var colorChipCollectionView: ColorChipCollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    private func commonInit() {
        textfield.becomeFirstResponder()
        textfield.returnKeyType = .done
        textfield.font = UIFont.nanumRegularFont(ofSize: 13.0)
        textfield.placeholder = "콜렉션의 이름을 입력해주세요"
        titleLabel.font = UIFont.nanumHeadlineBold17()
        baseView.clipsToBounds = true
        baseView.layer.masksToBounds = false
        baseView.layer.cornerRadius = 14.0
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.text = editMode == .create ? "새 콜렉션 추가" : "콜렉션 수정"
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
