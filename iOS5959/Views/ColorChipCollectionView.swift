//
//  ColorChipCollectionView.swift
//  iOS5959
//
//  Created by 최혜선 on 2020/01/02.
//  Copyright © 2020 5959. All rights reserved.
//

import UIKit

let selectCollectionColorNotification = NSNotification.Name(rawValue: "selectCollectionColorNotification")

class ColorChipCollectionView: UICollectionView {
    
    fileprivate var colorList: [UIColor] = [.primaryCoral, .primaryRed, .primaryPink,
                                .primaryIndigo, .primaryPurple, .primaryViolet,
                                .primaryYellow, .primaryGreen, .primarySky,
                                .primaryOcean, .primaryBlue, .primaryBlack]
    
    var currentColor: UIColor = .black
    
    func setCollectionsColor(color hexString: String?, editMode: EditMode) {
        let index = colorList.firstIndex(where: { $0.toHexString().uppercased() == hexString }) ?? 11
        let indexPath = IndexPath(row: editMode == .create ? 11 : index, section: 0)
        collectionView(self, didSelectItemAt: indexPath)
    }
    
    private let cellIdentifier = "colorCell"
    
    private func configure() {
        self.delegate = self
        self.dataSource = self
        self.isScrollEnabled = false
        self.isPagingEnabled = false
        self.isMultipleTouchEnabled = false
        self.register(UINib(nibName: "ColorChipCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
    }
    
    fileprivate func deSelectAllRows() {
        for section in 0..<self.numberOfSections {
            for row in 0..<self.numberOfItems(inSection: section) {
                let indexPath = IndexPath(row: row, section: section)
                collectionView(self, didDeselectItemAt: indexPath)
            }
        }
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
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? ColorChipCollectionViewCell {
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
        // cell을 선택하면 체크 이미지를 표시합니다
        if let cell = collectionView.cellForItem(at: indexPath) as? ColorChipCollectionViewCell {
            deSelectAllRows()
            cell.showCheck()
        }
        
        // 색상을 선택하면 Notification 을 발송합니다 - ["color": color value]
        NotificationCenter.default.post(name: selectCollectionColorNotification,
                                        object: nil,
                                        userInfo: ["colorValue": colorList[indexPath.row]])
        currentColor = colorList[indexPath.row]
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        // 다른 cell을 선택하면 체크 이미지를 숨깁니다
        if let cell = collectionView.cellForItem(at: indexPath) as? ColorChipCollectionViewCell {
            cell.hideCheck()
        }
    }
}

extension ColorChipCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 40.0, height: 40.0)
    }
}
