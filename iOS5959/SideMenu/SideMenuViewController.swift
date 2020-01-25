//
//  SideMenuViewController.swift
//  iOS5959
//
//  Created by 최혜선 on 2019/12/29.
//  Copyright © 2019 5959. All rights reserved.
//

import UIKit
import SideMenu

class SideMenuViewController: UIViewController {
    
    @IBOutlet fileprivate weak var sideMenuTableView: SideMenuTableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        sideMenuTableView.newCollectDelegate = self
        sideMenuTableView.itemDelegate = self
        sideMenuTableView.reloadData()
    }
}

extension SideMenuViewController: SideMenuItemDelegate {
    func modifyCollection(index: Int) {
        showModifyCollectionSetting()
    }
    
    func selectCollection(index: Int) {
        // 콜렉션 선택
        SideMenuManager.default.leftMenuNavigationController?.dismiss(animated: true, completion: nil)
    }
    
    private func showModifyCollectionSetting() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        // 삭제
        let deleteAction = UIAlertAction(title: "콜렉션 삭제", style: .destructive) { (_) in
            self.showAlertController(title: "콜렉션 삭제", description: "해당 콜렉션을 삭제하시겠습니까?\n콜렉션 내 모든 상품도 함께 삭제됩니다.")
        }
        // 기본 설정
        let setDefaultAction = UIAlertAction(title: "기본 콜렉션으로 설정", style: .default) { (_) in
            self.showAlertController(title: "기본 콜렉션으로 설정", description: "기본 콜렉션으로 설정하시겠습니까?")
        }
        // 수정
        let modifyAction = UIAlertAction(title: "콜렉션 수정", style: .default) { (_) in
            let modifyCollectionViewController = ModifyCollectionViewController()
            modifyCollectionViewController.editMode = .modify
            modifyCollectionViewController.modalPresentationStyle = .fullScreen
            DispatchQueue.main.async {
                self.present(modifyCollectionViewController, animated: true, completion: nil)
            }
        }
        // 취소
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alertController.addAction(deleteAction)
        alertController.addAction(setDefaultAction)
        alertController.addAction(modifyAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func showAlertController(title: String?, description message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "아니오", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "예", style: .default) { (_) in
            // TODO: Handler
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension SideMenuViewController: SideMenuTableViewDelegate {
    func makeNewCollection() {
        let modifyCollectionViewController = ModifyCollectionViewController()
        modifyCollectionViewController.editMode = .create
        modifyCollectionViewController.modalPresentationStyle = .fullScreen
        DispatchQueue.main.async {
            self.present(modifyCollectionViewController, animated: true, completion: nil)
        }
    }
}
