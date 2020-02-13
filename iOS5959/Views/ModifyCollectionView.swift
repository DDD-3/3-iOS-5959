//
//  ModifyCollectionView.swift
//  iOS5959
//
//  Created by 최혜선 on 2020/01/02.
//  Copyright © 2020 5959. All rights reserved.
//

import UIKit

protocol ModifyCollectionViewDelegate: class {
    func touchedCancelButton()
    func touchedConfirmButton(color: UIColor, name: String)
}

class ModifyCollectionView: UIView {
    var editMode: EditMode = .create
    var item: CollectionItem?
    weak var delegate: ModifyCollectionViewDelegate?
    @IBOutlet fileprivate weak var cancelButton: UIButton!
    @IBOutlet fileprivate weak var confirmButton: UIButton!
    @IBOutlet fileprivate weak var colorView: UIView!
    @IBOutlet fileprivate weak var baseView: UIView!
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var textfieldBackgroundView: UIView!
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
        textfield.font = UIFont.nanumRegularFont(ofSize: 18.0)
        textfield.placeholder = "콜렉션의 이름을 입력해주세요"
        textfield.borderStyle = .none
        textfield.textAlignment = .center
        titleLabel.font = UIFont.nanumHeadlineBold17()
        baseView.clipsToBounds = true
        baseView.layer.masksToBounds = false
        baseView.layer.cornerRadius = 14.0
        colorView.clipsToBounds = true
        colorView.layer.cornerRadius = colorView.frame.width / 2
        textfieldBackgroundView.clipsToBounds = true
        textfieldBackgroundView.backgroundColor = .primaryCement
        textfieldBackgroundView.layer.cornerRadius = 25.0
        cancelButton.addTarget(self, action: #selector(touchedCancelButton(_:)), for: .touchUpInside)
        confirmButton.addTarget(self, action: #selector(touchedConfirmButton(_:)), for: .touchUpInside)
        
        // 색상 선택에 대한 Notification observer 를 추가합니다 - to change "colorView"'s background color
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(changeCollectionColorObserver),
                                               name: selectCollectionColorNotification, object: nil)
    }
    
    /// 색상 선택 notification observer
    @objc private func changeCollectionColorObserver(_ noti: Notification) {
        if let color = noti.userInfo?["colorValue"] as? UIColor {
            colorView.backgroundColor = color
        }
    }
    
    /// 취소 버튼 선택 target method
    @objc private func touchedCancelButton(_ sender: UIButton) {
        // remove Notification observer
        NotificationCenter.default.removeObserver(self, name: selectCollectionColorNotification, object: nil)
        delegate?.touchedCancelButton()
    }
    
    /// 확인 버튼 선택 target method
    @objc private func touchedConfirmButton(_ sender: UIButton) {
        if let collectionName = textfield.text {
            // remove Notification observer
            delegate?.touchedConfirmButton(color: colorChipCollectionView.currentColor, name: collectionName)
            NotificationCenter.default.removeObserver(self, name: selectCollectionColorNotification, object: nil)
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        item = Singleton.shared.currentCollection
                
        // editMode에 따른 값 설정
        switch editMode {
        case .create:
            titleLabel.text = "새 콜렉션 추가"
            textfield.text = nil
        case .modify:
            titleLabel.text = "콜렉션 수정"
            textfield.text = item?.title
        }
        
        // 콜렉션 정보에 저장된 색상을 확인하고 체크 표시 진행
        colorChipCollectionView.setCollectionsColor(color: item?.color, editMode: editMode)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
}
