//
//  ViewController.swift
//  iOS5959
//
//  Created by 최혜선 on 2019/12/06.
//  Copyright © 2019 jamie. All rights reserved.
//

import UIKit
import SideMenu
import Magnetic
import SwiftKeychainWrapper

class ViewController: UIViewController, MagneticDelegate {
    func magnetic(_ magnetic: Magnetic, didSelect node: Node) {
        let ItemViewStoryboard = UIStoryboard(name: "ItemView", bundle: nil)
        guard let ItemDetailVC = ItemViewStoryboard.instantiateViewController(identifier: "ItemDetailVC") as? ItemDetailVC else {return}
        
        for node in magnetic.selectedChildren{
            node.deselectedAnimation()
        }
        
        ItemDetailVC.nodeTagID = Int(node.accessibilityHint!)
        ItemDetailVC.selectedNode = node
        self.navigationController?.pushViewController(ItemDetailVC, animated: true)
    }
    
    func magnetic(_ magnetic: Magnetic, didDeselect node: Node) {
        
    }
    
    /// Magnetic View
    @IBOutlet var magneticView: MagneticView!
    var magnetic: Magnetic?
    
    /// Navigation Title View
    private var titleView: CollectionTitleView!

    
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
        // 콜렉션 수정에 대한 노티 (현재 선택된 타이틀이 변경된 경우 체크해서 메인 타이틀 변경)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(changeTitleObserver(_:)),
                                               name: requestChangeMainTitleNotification,
                                               object: nil)
        requestRegistUser()
        magnetic = magneticView.magnetic
        loadMagneticDataSource(magnetic: magnetic!)
        magneticView.magnetic.magneticDelegate = self
    }
    

    private func requestRegistUser() {
        let key = "userToken"
        let firstLaunch = FirstLaunch()
        if firstLaunch.isFirstLaunch {
            // 설치 후 첫 실행
            // Keychain에서 디바이스 UUID 저장하기
            let uuidString = UUID().uuidString
            KeychainWrapper.standard.set(uuidString, forKey: key)
            UserDefaults.standard.set(uuidString, forKey: key)
            // 등록 API 실행
            print("등록 API 실행")
            
            switch registUser(regist: Regist(token: uuidString)) {
            case .success:
                excuteLogin()
            case .fail:
                showAlertController(title: "에러 발생", message: "에러 메세지가 위치하는 곳", completionHandler: nil)
            case .server:
                showAlertController()
            }
        } else {
            let userToken = KeychainWrapper.standard.string(forKey: key)
            UserDefaults.standard.set(userToken, forKey: key)
            excuteLogin()
        }
    }
    
    private func excuteLogin() {
        // Login API 실행
        print("Login API 실행")
        let uuidString = UserDefaults.standard.string(forKey: "userToken") ?? ""
        print("UUID \(uuidString)")
        var login: Login!
        let statusCode = requestLogin(regist: Regist(token: uuidString)) { (result) in
            login = result
        }
        switch statusCode {
        case .success:
            if KeychainWrapper.standard.string(forKey: "accessToken") == nil {
                KeychainWrapper.standard.set(login.data.accessToken, forKey: "accessToken")
                KeychainWrapper.standard.set(login.data.refreshToken, forKey: "refreshToken")
            }
            UserDefaults.standard.set(login.data.accessToken, forKey: "accessToken")
            // 콜렉션 조회
            excuteCollectionList()
        case .fail:
            showAlertController(title: "에러 발생", message: "에러 메세지가 위치하는 곳", completionHandler: nil)
        case .server:
            showAlertController()
        }
    }
    
    private func excuteCollectionList() {
        let _ = requestWholeCollection { (collection) in
            Singleton.shared.collectionList = collection.data
            self.setDefaultCollection()
        }
    }
    
    private func setDefaultCollection() {
        Singleton.shared.currentCollection = Singleton.shared.defaultCollection
        DispatchQueue.main.async {
            self.titleView.changeTitle(title: Singleton.shared.currentCollection!.title, showWhole: false)
        }
    }
    
    @IBAction func openWebView() {
        let webviewstoryboard = UIStoryboard(name: "WishBallWebView", bundle: nil)
        let webview = webviewstoryboard.instantiateViewController(withIdentifier: "WishBallWebViewController") as! WishBallWebViewController
        self.present(webview, animated: true, completion: nil)
    }
    
    @objc private func changeTitleObserver(_ noti: Notification) {
        DispatchQueue.main.async {
            self.titleView.changeTitle(title: Singleton.shared.currentCollection!.title, showWhole: false)
        }
    }
    
    @objc private func selectCollection(_ noti: Notification) {
        print("콜렉션을 선택했습니다")
        // navigation title 변경
        if let data = noti.userInfo?["collection"] as? CollectionItem {
            titleView.changeTitle(title: data.title, showWhole: false)
        }
        // TODO: 데이터 갱신
    }
    
    @objc private func selectWholeCollection(_ noti: Notification) {
        print("전체보기 선택 노티")
        titleView.changeTitle(title: "전체보기", showWhole: true)
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
    
    private func setNavigationBar() {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_menu"), style: .plain, target: self, action: #selector(touchedSideMenuButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_list"), style: .plain, target: self, action: #selector(touchedListToggleButton))
        setNavigationTitle()
    }
    
    private func setNavigationTitle() {
        titleView = CollectionTitleView(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        titleView.delegate = self
        navigationItem.titleView = titleView
    }
    
    private func loadMagneticDataSource(magnetic: Magnetic) {
        var wish: Wish!
        let statusCode = requestWishItems(completion: {(result) in
            wish = result})
        switch statusCode {
        case .success:
            for data in wish.data! {
                if data.collectionID == Singleton.shared.currentCollection?.collectionID {
                    for wishItem in data.wishItems {
                        let node = Node(text: wishItem.name, image: UIImage(named: "find"), color: UIColor.blue, radius: (CGFloat(30 + 30 * wishItem.importance / 5)), marginScale: 1)
                        node.accessibilityHint = "\(wishItem.wishItemID)"
                        magnetic.addChild(node)
                    }
                }
            }
        case .fail:
            print("Request Wish Items Fetch Failure")
        case .server:
            print("Request Wish Items Error on Server")
        
        }
    }
}

extension ViewController: CollectionTitleViewDelegate {
    func touchedModifyCollection() {
        let modifyCollectionViewController = ModifyCollectionViewController()
        modifyCollectionViewController.editMode = .modify
        modifyCollectionViewController.currentCollection = Singleton.shared.currentCollection
        self.present(modifyCollectionViewController, animated: true, completion: nil)
    }
}
