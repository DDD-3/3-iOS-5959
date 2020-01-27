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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setNavigationBar()
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
        navigationItem.title = "WishBall"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(touchedSideMenuButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "list"), style: .plain, target: self, action: #selector(touchedListToggleButton))
        setNavigationTitle()
    }
    
    private func setNavigationTitle() {
        let titleButton = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        titleButton.setImage(UIImage(systemName: "circle.grid.2x2"), for: .normal)
        titleButton.setTitle("WishBall", for: .normal)
        titleButton.setTitleColor(.black, for: .normal)
        titleButton.titleLabel?.font = UIFont.nanumExtraBoldFont(ofSize: 17.0)
        titleButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 11, bottom: 0, right: 0)
        titleButton.semanticContentAttribute = .forceRightToLeft
        titleButton.addTarget(self, action: #selector(touchedModifyCollection), for: .touchUpInside)
        navigationItem.titleView = titleButton
    }
}

