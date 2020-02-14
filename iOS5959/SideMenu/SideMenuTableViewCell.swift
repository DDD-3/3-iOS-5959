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
        lb.font = UIFont.nanumBodyRegular14()
        return lb
    }()
    
    private let defaultTypeLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.nanumBodyRegular14()
        lb.text = "(기본)"
        return lb
    }()
    
    private let moreButton: UIButton = {
       let lb = UIButton()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.setImage(UIImage(systemName: "ellipsis")?.withRenderingMode(.alwaysOriginal).withTintColor(.black), for: .normal)
        return lb
    }()

    var collection: CollectionItem! {
        didSet {
            collectionNameLabel.text = collection.title
            colorChipView.backgroundColor = UIColor(hexString: collection.color)
            self.tag = collection.collectionID
            defaultTypeLabel.isHidden = collection.collectionType == .nonDefaultType
        }
    }
    
    func configure() {
        self.backgroundColor = .white
        let stackView = UIStackView(arrangedSubviews: [collectionNameLabel, defaultTypeLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        addSubview(colorChipView)
        addSubview(moreButton)
        addSubview(stackView)
        
        colorChipView.widthAnchor.constraint(equalToConstant: 18.0).isActive = true
        colorChipView.heightAnchor.constraint(equalToConstant: 18.0).isActive = true
        colorChipView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        colorChipView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24.0).isActive = true
        colorChipView.trailingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: -11.0).isActive = true

        stackView.centerYAnchor.constraint(equalTo: colorChipView.centerYAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: moreButton.leadingAnchor, constant: -5.0).isActive = true
        
        moreButton.centerYAnchor.constraint(equalTo: colorChipView.centerYAnchor).isActive = true
        moreButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24.0).isActive = true
        moreButton.addTarget(self, action: #selector(touchedMoreButton(_:)), for: .touchUpInside)

        collectionNameLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        moreButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
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
        defaultTypeLabel.isHidden = true
    }
}
