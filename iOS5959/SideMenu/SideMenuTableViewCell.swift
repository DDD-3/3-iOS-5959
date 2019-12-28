//
//  SideMenuTableViewCell.swift
//  iOS5959
//
//  Created by 최혜선 on 2019/12/29.
//  Copyright © 2019 5959. All rights reserved.
//

import UIKit

class SideMenuTableViewCell: UITableViewCell {
    
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
        lb.font = UIFont.systemFont(ofSize: 17.0)
        return lb
    }()
    
    private let moreButton: UIButton = {
       let lb = UIButton()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.setImage(UIImage(systemName: "circle.grid.2x2"), for: .normal)
        return lb
    }()

    var collectionName: String = "" {
        didSet {
            collectionNameLabel.text = collectionName
        }
    }
    
    
    private func configure() {
        addSubview(colorChipView)
        addSubview(collectionNameLabel)
        addSubview(moreButton)
        
        colorChipView.widthAnchor.constraint(equalToConstant: 18.0).isActive = true
        colorChipView.heightAnchor.constraint(equalToConstant: 18.0).isActive = true
        colorChipView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        colorChipView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 51.0).isActive = true
        colorChipView.trailingAnchor.constraint(equalTo: self.collectionNameLabel.leadingAnchor, constant: -11.0).isActive = true

        collectionNameLabel.centerYAnchor.constraint(equalTo: colorChipView.centerYAnchor).isActive = true
        collectionNameLabel.trailingAnchor.constraint(equalTo: self.moreButton.leadingAnchor).isActive = true
        
        moreButton.centerYAnchor.constraint(equalTo: colorChipView.centerYAnchor).isActive = true
        moreButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24.0).isActive = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configure()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        collectionNameLabel.text = nil
    }
}
