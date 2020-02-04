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

class ViewController: UIViewController {
    /// Magnetic View
    @IBOutlet var magneticView: MagneticView!
    var magnetic: Magnetic?
    
    /// Navigation Title View
    private var titleView: CollectionTitleView!

    override func loadView() {
        super.loadView()
        magnetic = magneticView.magnetic
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
    
    @IBAction func openWebView() {
        let webviewstoryboard = UIStoryboard(name: "WishBallWebView", bundle: nil)
        let webview = webviewstoryboard.instantiateViewController(withIdentifier: "WishBallWebViewController") as! WishBallWebViewController
        self.present(webview, animated: true, completion: nil)
    }
    
    @objc private func selectCollection(_ noti: Notification) {
        print("콜렉션 선택 노티~")
        // TODO: navigation title 변경
        if let data = noti.userInfo?["selectCollection"] as? Int {
            titleView.changeTitle(title: "콜렉션 \(data)", showWhole: false)
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(touchedSideMenuButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "list"), style: .plain, target: self, action: #selector(touchedListToggleButton))
        setNavigationTitle()
    }
    
    private func setNavigationTitle() {
        titleView = CollectionTitleView(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        titleView.delegate = self
        navigationItem.titleView = titleView
    }
}

extension ViewController: CollectionTitleViewDelegate {
    func touchedModifyCollection() {
        print("콜렉션 수정")
        let modifyCollectionViewController = ModifyCollectionViewController()
        modifyCollectionViewController.editMode = .modify
        modifyCollectionViewController.modalPresentationStyle = .fullScreen
        self.present(modifyCollectionViewController, animated: true, completion: nil)
    }
}
