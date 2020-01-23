//
//  SideMenuTableView.swift
//  iOS5959
//
//  Created by 최혜선 on 2019/12/29.
//  Copyright © 2019 5959. All rights reserved.
//

import UIKit

class SideMenuTableView: UITableView {
    
    weak var itemDelegate: SideMenuItemDelegate?
    
    private func configure() {
        self.delegate = self
        self.dataSource = self
        self.tableFooterView = UIView(frame: .zero)
        self.backgroundColor = .primaryCement
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        configure()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension SideMenuTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "sideMenuCell", for: indexPath) as? SideMenuTableViewCell {
            cell.delegate = self
            cell.tag = indexPath.row
            cell.selectionStyle = .none
            cell.collectionName = "콜렉션 \(indexPath.row + 1)"
            return cell
        }
        
        fatalError("사이드메뉴 Cell 에러")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let containerView = UIView(frame: CGRect(x: 16, y: 0, width: 150, height: 65))
        containerView.backgroundColor = .primaryCement
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 50, width: 150, height: 65))
        containerView.addSubview(titleLabel)
        titleLabel.center = containerView.center
        titleLabel.font = UIFont.nanumHeadlineExtraBold12()
        titleLabel.textColor = .secondaryGrey
        titleLabel.text = "콜렉션"
        return containerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        containerView.backgroundColor = .primaryCement
        let newCollectionButton = UIButton(frame: CGRect(x: 36, y: 0, width: 150, height: 50))
        containerView.addSubview(newCollectionButton)
        newCollectionButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 11, bottom: 0, right: 0)
        newCollectionButton.setImage(UIImage(named: "icon_ItemReason")?.withRenderingMode(.alwaysOriginal).withTintColor(.inactiveBlack), for: .normal)
        newCollectionButton.titleLabel?.font = UIFont.nanumRegularFont(ofSize: 17.0)
        newCollectionButton.setTitleColor(.inactiveBlack, for: .normal)
        newCollectionButton.setTitle("새 콜렉션 추가", for: .normal)
        return containerView
    }
}

extension SideMenuTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("사이드 메뉴 선택 \(indexPath.row)")
        itemDelegate?.selectCollection(index: indexPath.row)
    }
}

extension SideMenuTableView: SideMenuItemDelegate {
    func selectCollection(index: Int) {
        itemDelegate?.selectCollection(index: index)
    }
    
    func modifyCollection(index: Int) {
        print("콜렉션 설정 \(index)")
        itemDelegate?.modifyCollection(index: index)
    }
}
