//
//  SideMenuTableView.swift
//  iOS5959
//
//  Created by 최혜선 on 2019/12/29.
//  Copyright © 2019 5959. All rights reserved.
//

import UIKit

protocol SideMenuTableViewDelegate: class {
    func showWholeCollection()
    func makeNewCollection()
}

class SideMenuTableView: UITableView {
    
    weak var sidemenuDelegate: SideMenuTableViewDelegate?
    weak var itemDelegate: SideMenuItemDelegate?
    /// 콜렉션 리스트
    var collectionList: [CollectionItem] = []
    /// 현재 선택된 콜렉션 Index
    fileprivate var selectedIndex: Int {
        return collectionList.firstIndex(where: { $0.collectionID == Singleton.shared.currentCollection?.collectionID }) ?? 0
    }
    
    private func configure() {
        self.delegate = self
        self.dataSource = self
        self.tableFooterView = UIView(frame: .zero)
        self.backgroundColor = .white
        self.separatorColor = .primaryCement
        self.rowHeight = 48
        self.sectionHeaderHeight = 48
        self.sectionFooterHeight = 48
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
            cell.configure()
            cell.collection = collectionList[indexPath.row]
            // 현재 선택한 row selected
            tableView.selectRow(at: IndexPath(row: selectedIndex, section: 0),
                                animated: false, scrollPosition: .none)
            
            let bgColorView = UIView()
            bgColorView.backgroundColor = UIColor.primaryCement
            cell.selectedBackgroundView = bgColorView
            return cell
        }
        
        fatalError("사이드메뉴 Cell 에러")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collectionList.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let containerView = UIView(frame: CGRect(x: 24, y: 0, width: 150, height: tableView.sectionHeaderHeight))
        containerView.backgroundColor = .white
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0,
                                               width: containerView.frame.width, height: containerView.frame.height))
        containerView.addSubview(titleLabel)
        titleLabel.center = containerView.center
        titleLabel.font = UIFont.nanumBodyRegular14()
        titleLabel.textColor = .black
        titleLabel.text = "전체보기"
        
        let sepFrame = CGRect(x: 0, y: containerView.frame.height - 5,
                              width: tableView.frame.width, height: 0.5)
        let seperatorView = UIView(frame: sepFrame)
        seperatorView.backgroundColor = UIColor.primaryCement
        containerView.addSubview(seperatorView)
        containerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(touchedWholeCollection)))
        return containerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let containerView = UIView(frame: CGRect(x: 24, y: 0, width: 150, height: tableView.sectionFooterHeight))
        containerView.backgroundColor = .white
        let newCollectionButton = UIButton(frame: CGRect(x: 0, y: 0, width: containerView.frame.width, height: containerView.frame.height))
        containerView.addSubview(newCollectionButton)
        newCollectionButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0)
        newCollectionButton.setImage(UIImage(named: "icon_plus_circle"), for: .normal)
        newCollectionButton.titleLabel?.font = UIFont.nanumBodyRegular14()
        newCollectionButton.setTitleColor(.inactiveBlack, for: .normal)
        newCollectionButton.setTitle("새 콜렉션 추가", for: .normal)
        newCollectionButton.addTarget(self, action: #selector(touchedNewCollectionButton(_:)), for: .touchUpInside)
        
        let sepFrame = CGRect(x: 5, y: 0, width: containerView.frame.width - 5, height: 0.5)
        let seperatorView = UIView(frame: sepFrame)
        seperatorView.backgroundColor = UIColor.primaryCement
        containerView.addSubview(seperatorView)
        return containerView
    }
    
    @objc private func touchedWholeCollection() {
        sidemenuDelegate?.showWholeCollection()
    }
    
    @objc private func touchedNewCollectionButton(_ sender: UIButton) {
        print("새 콜렉션을 추가합니다")
        sidemenuDelegate?.makeNewCollection()
    }
}

extension SideMenuTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemDelegate?.selectCollection(index: collectionList[indexPath.row].collectionID)
    }
}

extension SideMenuTableView: SideMenuItemDelegate {
    func selectCollection(index: Int) {
        itemDelegate?.selectCollection(index: index)
    }
    
    func modifyCollection(index: Int) {
        itemDelegate?.modifyCollection(index: index)
    }
}
