//
//  CollectionTitleView.swift
//  iOS5959
//
//  Created by 최혜선 on 2020/02/01.
//  Copyright © 2020 5959. All rights reserved.
//

import UIKit

protocol CollectionTitleViewDelegate: class {
    func touchedModifyCollection()
}

class CollectionTitleView: UIView {
    weak var delegate: CollectionTitleViewDelegate?
    
    private var title: UIButton = {
       let lb = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        lb.setImage(UIImage(), for: .disabled)
        lb.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        lb.setTitleColor(.black, for: .normal)
        lb.titleLabel?.font = UIFont.nanumExtraBoldFont(ofSize: 17.0)
        lb.imageEdgeInsets = UIEdgeInsets(top: 0, left: 11, bottom: 0, right: 0)
        lb.semanticContentAttribute = .forceRightToLeft
        lb.addTarget(self, action: #selector(touchedModifyCollection), for: .touchUpInside)
        return lb
    }()
    
    private var collectionTitle: String = "WishBall" {
        didSet {
            title.setTitle(collectionTitle, for: .normal)
        }
    }
    
    private var showWholeCollectionMode: Bool = false {
        didSet {
            title.isEnabled = !showWholeCollectionMode
        }
    }
    
    func changeTitle(title: String, showWhole: Bool) {
        collectionTitle = title
        showWholeCollectionMode = showWhole
    }
    
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
    
    @objc private func touchedModifyCollection() {
        delegate?.touchedModifyCollection()
    }
    
    private func commonInit() {
        addSubview(title)
        title.setTitle(collectionTitle, for: .normal)
    }
}
