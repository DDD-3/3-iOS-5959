//
//  ColorChipCollectionView.swift
//  iOS5959
//
//  Created by 최혜선 on 2020/01/02.
//  Copyright © 2020 5959. All rights reserved.
//

import UIKit

class ColorChipCollectionView: UICollectionView {
    
    fileprivate var colorList: [UIColor] = [.primaryCoral, .primaryRed, .primaryPink,
                                            .primaryIndigo, .primaryPurple, .primaryViolet,
                                            .primaryYellow, .primaryGreen, .primarySky,
                                            .primaryOcean, .primaryBlue, .primaryBlack]
    
    private func configure() {
        self.delegate = self
        self.dataSource = self
        self.isScrollEnabled = false
        self.isPagingEnabled = false
        self.isMultipleTouchEnabled = false
        self.register(UINib(nibName: "ColorChipCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "colorCell")
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
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

extension ColorChipCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorCell", for: indexPath) as? ColorChipCollectionViewCell {
            cell.clipsToBounds = true
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = cell.frame.width / 2
            cell.color = colorList[indexPath.row]
            return cell
        }
        
        fatalError("color chip error")
    }
}

extension ColorChipCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("색상 선택 \(indexPath.row)")
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 2.0
        cell?.layer.borderColor = UIColor.black.cgColor
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        print("색상 선택 해제 \(indexPath.row)")
        cell?.layer.borderColor = nil
        cell?.layer.borderWidth = 0.0
    }
}

extension ColorChipCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 35.0, height: 35.0)
    }
}
