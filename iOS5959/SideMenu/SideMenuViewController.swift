//
//  SideMenuViewController.swift
//  iOS5959
//
//  Created by 최혜선 on 2019/12/29.
//  Copyright © 2019 5959. All rights reserved.
//

import UIKit
import SideMenu

let selectCollectionNotification = NSNotification.Name(rawValue: "selectCollectionNotification")
let selectWholeCollectionNotification = NSNotification.Name(rawValue: "selectWholeDataNotification")

class SideMenuViewController: UIViewController {
    
    fileprivate var collectionList = Singleton.shared.collectionList
    fileprivate let wholeCollection = CollectionItem(collectionID: -1,
                                                     collectionType: .nonDefaultType,
                                                     title: "전체보기", color: "#000000")
    @IBOutlet fileprivate weak var sideMenuTableView: SideMenuTableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionList.insert(wholeCollection, at: 0)
        sideMenuTableView.newCollectDelegate = self
        sideMenuTableView.itemDelegate = self
        sideMenuTableView.collectionList = collectionList
        sideMenuTableView.reloadData()
    }
}

extension SideMenuViewController: SideMenuItemDelegate {
    func modifyCollection(index: Int) {
        showModifyCollectionSetting(index: index)
    }
    
    func selectCollection(index: Int) {
        // 콜렉션 선택
        if index == -1 {
            print("전체보기")
            NotificationCenter.default.post(
            name: selectWholeCollectionNotification,
            object: nil,
            userInfo: nil)
        } else {
            let collection = Singleton.shared.getCurrentCollection(collectionId: index)
            Singleton.shared.currentCollection = collection
            NotificationCenter.default.post(
                name: selectCollectionNotification,
                object: nil,
                userInfo: ["collection": collection])
        }
        SideMenuManager.default.leftMenuNavigationController?.dismiss(animated: true, completion: nil)
    }
    
    private func showModifyCollectionSetting(index: Int) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        // 삭제
        let deleteAction = UIAlertAction(title: "콜렉션 삭제", style: .destructive) { (_) in
            self.showAlertController(title: "콜렉션 삭제", message: "해당 콜렉션을 삭제하시겠습니까?\n콜렉션 내 모든 상품도 함께 삭제됩니다.")
        }
        // 기본 설정
        let setDefaultAction = UIAlertAction(title: "기본 콜렉션으로 설정", style: .default) { (_) in
            self.showAlertController(title: "기본 콜렉션으로 설정", message: "기본 콜렉션으로 설정하시겠습니까?")
        }
        // 수정
        let modifyAction = UIAlertAction(title: "콜렉션 수정", style: .default) { (_) in
            let modifyCollectionViewController = ModifyCollectionViewController()
            modifyCollectionViewController.editMode = .modify
            // 사이드메뉴에서 수정하려는 콜렉션 아이템 추출
            let collection = Singleton.shared.getCurrentCollection(collectionId: index)
            // 수정할 콜렉션 property 전달
            modifyCollectionViewController.currentCollection = collection
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
}

extension SideMenuViewController: SideMenuTableViewDelegate {
    func makeNewCollection() {
        let modifyCollectionViewController = ModifyCollectionViewController()
        modifyCollectionViewController.editMode = .create
        DispatchQueue.main.async {
            self.present(modifyCollectionViewController, animated: true, completion: nil)
        }
    }
}
