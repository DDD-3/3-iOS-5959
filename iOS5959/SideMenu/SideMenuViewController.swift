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
let requestCollectionListNotification = NSNotification.Name(rawValue: "requestCollectionListNotification")

class SideMenuViewController: UIViewController {
    
    fileprivate var collectionList = Singleton.shared.collectionList
    @IBOutlet fileprivate weak var sideMenuTableView: SideMenuTableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        sideMenuTableView.sidemenuDelegate = self
        sideMenuTableView.itemDelegate = self
        sideMenuTableView.collectionList = collectionList
        sideMenuTableView.reloadData()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(excuteCollectionListObserver),
                                               name: requestCollectionListNotification, object: nil)
    }
    
    @objc private func excuteCollectionListObserver() {
        print("콜렉션이 수정/삭제/추가되어 리스트를 조회합니다")
        let _ = requestWholeCollection { (collection) in
            DispatchQueue.main.async {
                Singleton.shared.collectionList = collection.data
                self.sideMenuTableView.collectionList = collection.data
                self.sideMenuTableView.reloadData()
            }
        }
    }
}

extension SideMenuViewController: SideMenuItemDelegate {
    func modifyCollection(index: Int) {
        showModifyCollectionSetting(index: index)
    }
    
    func selectCollection(index: Int) {
        // 콜렉션 선택
        let collection = Singleton.shared.getCurrentCollection(collectionId: index)
        Singleton.shared.currentCollection = collection
        NotificationCenter.default.post(
            name: selectCollectionNotification,
            object: nil,
            userInfo: ["collection": collection])
        SideMenuManager.default.leftMenuNavigationController?.dismiss(animated: true, completion: nil)
    }
    
    private func showModifyCollectionSetting(index: Int) {
        // 사이드메뉴에서 수정하려는 콜렉션 아이템 추출
        let collection = Singleton.shared.getCurrentCollection(collectionId: index)
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        // 삭제
        let deleteAction = UIAlertAction(title: "콜렉션 삭제", style: .destructive) { (_) in
            self.showDeleteCollection(collection: collection)
        }
        // 기본 설정
        let setDefaultAction = UIAlertAction(title: "기본 콜렉션으로 설정", style: .default) { (_) in
            self.showSetDefaultCollection(collection: collection)
        }
        // 수정
        let modifyAction = UIAlertAction(title: "콜렉션 수정", style: .default) { (_) in
            let modifyCollectionViewController = ModifyCollectionViewController()
            modifyCollectionViewController.editMode = .modify
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
    
    private func showDeleteCollection(collection: CollectionItem?) {
        guard let collection = collection else {
            return
        }
        
        // 콜렉션 타입이 기본인 경우 삭제 불가
        guard collection.collectionType != .defaultType else {
            showAlertController(title: "알림", message: "기본 콜렉션은 삭제할 수 없습니다", completionHandler: nil)
            return
        }
        
        // 현재 선택된 콜렉션인 경우 삭제 불가
        guard collection.collectionID != Singleton.shared.currentCollection?.collectionID else {
            showAlertController(title: "알림", message: "현재 선택된 콜렉션은 삭제할 수 없습니다", completionHandler: nil)
            return
        }
        // 기본 아닌 경우 삭제 진행
        showWarningAlertController(title: "콜렉션 삭제", message: "해당 콜렉션을 삭제하시겠습니까?\n콜렉션 내 모든 상품도 함께 삭제됩니다.") { (_) in
            // 삭제 API 호출
            let statusCode = requestDeleteCollection(collectionID: collection.collectionID)
            
            switch statusCode {
            case .success:
                NotificationCenter.default.post(name: requestCollectionListNotification, object: nil)
            case .fail:
                self.showAlertController(title: "에러 발생", message: "에러", completionHandler: nil)
            case .server:
                self.showAlertController()
            }
        }
    }
    
    /// 기본 콜렉션 설정
    private func showSetDefaultCollection(collection: CollectionItem?) {
        guard let collection = collection else {
            return
        }
        
        // 기본 콜렉션인 경우 재설정 불가
        guard collection.collectionType != .defaultType else {
            showAlertController(title: "알림", message: "기본 콜렉션으로 설정되어있습니다", completionHandler: nil)
            return
        }
        showWarningAlertController(title: "기본 콜렉션으로 설정", message: "기본 콜렉션으로 설정하시겠습니까?") { (_) in
            // 기본 콜렉션 설정 API 실행
            let statusCode = requestSetCollectionToDefault(collectionID: collection.collectionID)
            switch statusCode {
            case .success:
                NotificationCenter.default.post(name: requestCollectionListNotification, object: nil)
            case .fail:
                self.showAlertController(title: "에러 발생", message: "에러", completionHandler: nil)
            case .server:
                self.showAlertController()
            }
        }
    }
}

extension SideMenuViewController: SideMenuTableViewDelegate {
    func showWholeCollection() {
        // 콜렉션 전체보기
        NotificationCenter.default.post(
            name: selectWholeCollectionNotification,
            object: nil,
            userInfo: nil)
        SideMenuManager.default.leftMenuNavigationController?.dismiss(animated: true, completion: nil)
    }
    
    func makeNewCollection() {
        let modifyCollectionViewController = ModifyCollectionViewController()
        modifyCollectionViewController.editMode = .create
        DispatchQueue.main.async {
            self.present(modifyCollectionViewController, animated: true, completion: nil)
        }
    }
}
