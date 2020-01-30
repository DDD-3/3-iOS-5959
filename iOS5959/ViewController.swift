//
//  ViewController.swift
//  iOS5959
//
//  Created by 최혜선 on 2019/12/06.
//  Copyright © 2019 jamie. All rights reserved.
//

import UIKit
import SideMenu

class ViewController: UIViewController {
    /// Navigation Title View
    private var collectionTitle: UIButton!
    /// Navigation Title
    private var collectionTitleValue: String = "WishBall" {
        didSet {
            collectionTitle.setTitle(collectionTitleValue, for: .normal)
        }
    }
    /// 데이터 "전체보기" 모드
    private var showWholeCollection: Bool = false {
        didSet {
            collectionTitle.isEnabled = !showWholeCollection
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setNavigationBar()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(selectCollection(_:)),
                                               name: selectCollectionNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(selectWholeCollection(_:)),
                                               name: selectWholeCollectionNotification,
                                               object: nil)
    }
    
    @objc private func selectCollection(_ noti: Notification) {
        print("콜렉션 선택 노티~")
        showWholeCollection = false
        // TODO: navigation title 변경
        if let data = noti.userInfo?["selectCollection"] as? Int {
            collectionTitleValue = "콜렉션 \(data)"
        }
        // TODO: 데이터 갱신
    }
    
    @objc private func selectWholeCollection(_ noti: Notification) {
        print("전체보기 선택 노티")
        showWholeCollection = true
        collectionTitleValue = "전체보기"
        // TODO: 데이터 갱신
    }

    @objc private func touchedSideMenuButton() {
        if let sideMenu = self.storyboard?.instantiateViewController(withIdentifier: "SideMenuNavigationController") as? SideMenuNavigationController {
            SideMenuManager.default.leftMenuNavigationController = sideMenu
            sideMenu.statusBarEndAlpha = 0
            self.present(sideMenu, animated: true, completion: nil)
        }
    }
    
    @objc private func touchedListToggleButton() {
        print("리스트 전환")
    }
    
    @objc private func touchedModifyCollection() {
        print("콜렉션 수정")
        let modifyCollectionViewController = ModifyCollectionViewController()
        modifyCollectionViewController.editMode = .modify
        modifyCollectionViewController.modalPresentationStyle = .fullScreen
        self.present(modifyCollectionViewController, animated: true, completion: nil)
    }
    
    private func setNavigationBar() {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(touchedSideMenuButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "list"), style: .plain, target: self, action: #selector(touchedListToggleButton))
        setNavigationTitle()
    }
    
    private func setNavigationTitle() {
        collectionTitle = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        collectionTitle.setImage(UIImage(), for: .disabled)
        collectionTitle.setImage(UIImage(systemName: "circle.grid.2x2"), for: .normal)
        collectionTitle.setTitle(collectionTitleValue, for: .normal)
        collectionTitle.setTitleColor(.black, for: .normal)
        collectionTitle.titleLabel?.font = UIFont.nanumExtraBoldFont(ofSize: 17.0)
        collectionTitle.imageEdgeInsets = UIEdgeInsets(top: 0, left: 11, bottom: 0, right: 0)
        collectionTitle.semanticContentAttribute = .forceRightToLeft
        collectionTitle.addTarget(self, action: #selector(touchedModifyCollection), for: .touchUpInside)
        navigationItem.titleView = collectionTitle
    }
}

