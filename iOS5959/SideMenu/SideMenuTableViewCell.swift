//
//  SideMenuTableViewCell.swift
//  iOS5959
//
//  Created by 최혜선 on 2019/12/29.
//  Copyright © 2019 5959. All rights reserved.
//

import UIKit

protocol SideMenuItemDelegate: class {
    func modifyCollection(index: Int)
    func selectCollection(index: Int)
}

class SideMenuTableViewCell: UITableViewCell {
    
    enum ItemType {
        case whole
        case item
    }
    
    weak var delegate: SideMenuItemDelegate?
    
    private let colorChipView: UIView = {
       let lv = UIView()
        lv.translatesAutoresizingMaskIntoConstraints = false
        lv.clipsToBounds = true
        lv.layer.masksToBounds = false
        lv.layer.cornerRadius = lv.frame.width / 2
        lv.backgroundColor = .blue
        lv.layer.borderColor = UIColor.white.cgColor
        lv.layer.borderWidth = 2.0
        return lv
    }()
    
    private let collectionNameLabel: UILabel = {
       let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.nanumRegularFont(ofSize: 17.0)
        return lb
    }()
    
    private let moreButton: UIButton = {
       let lb = UIButton()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.setImage(UIImage(systemName: "ellipsis")?.withRenderingMode(.alwaysOriginal).withTintColor(.inactiveBlack), for: .normal)
        return lb
    }()

    var collection: CollectionItem! {
        didSet {
            collectionNameLabel.text = collection.title
            colorChipView.backgroundColor = UIColor(hexString: collection.color)
            self.tag = collection.collectionID
        }
    }
    
    func configure(type: ItemType) {
        self.backgroundColor = .primaryCement
        addSubview(colorChipView)
        addSubview(collectionNameLabel)
        addSubview(moreButton)
        
        colorChipView.widthAnchor.constraint(equalToConstant: 18.0).isActive = true
        colorChipView.heightAnchor.constraint(equalToConstant: 18.0).isActive = true
        colorChipView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        colorChipView.trailingAnchor.constraint(equalTo: self.collectionNameLabel.leadingAnchor, constant: -11.0).isActive = true

        collectionNameLabel.centerYAnchor.constraint(equalTo: colorChipView.centerYAnchor).isActive = true
        collectionNameLabel.trailingAnchor.constraint(equalTo: self.moreButton.leadingAnchor).isActive = true
        
        moreButton.centerYAnchor.constraint(equalTo: colorChipView.centerYAnchor).isActive = true
        moreButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24.0).isActive = true
        moreButton.addTarget(self, action: #selector(touchedMoreButton(_:)), for: .touchUpInside)
        
        if type == .item {
            colorChipView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 51.0).isActive = true
            moreButton.isHidden = false
        } else if type == .whole {
            colorChipView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 18.0).isActive = true
            moreButton.isHidden = true
            colorChipView.backgroundColor = .black
        }
    }
    
    @objc private func touchedMoreButton(_ sender: UIButton) {
        delegate?.modifyCollection(index: tag)
    }
    
    override func draw(_ rect: CGRect) {
        colorChipView.layer.cornerRadius = colorChipView.frame.width / 2
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        collectionNameLabel.text = nil
    }
}
