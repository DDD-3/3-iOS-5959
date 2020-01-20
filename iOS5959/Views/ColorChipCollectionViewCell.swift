//
//  ColorChipCollectionViewCell.swift
//  iOS5959
//
//  Created by 최혜선 on 2020/01/02.
//  Copyright © 2020 5959. All rights reserved.
//

import UIKit

class ColorChipCollectionViewCell: UICollectionViewCell {
    @IBOutlet fileprivate weak var colorChipView: UIView!
    
    var color: UIColor = .white {
        didSet {
            colorChipView.backgroundColor = color
        }
    }
    
    private func configure() {
        colorChipView.clipsToBounds = true
        colorChipView.layer.masksToBounds = true
        colorChipView.layer.cornerRadius = min(self.frame.size.height, self.frame.size.width) / 2.0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
}
