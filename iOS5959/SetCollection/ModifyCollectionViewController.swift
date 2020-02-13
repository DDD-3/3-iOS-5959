//
//  ModifyCollectionViewController.swift
//  iOS5959
//
//  Created by 최혜선 on 2020/01/02.
//  Copyright © 2020 5959. All rights reserved.
//

import UIKit

enum EditMode {
    case create
    case modify
}

class ModifyCollectionViewController: UIViewController {
    
    var editMode: EditMode = .create
    var currentCollection: CollectionItem?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let popup: ModifyCollectionView = UINib(nibName: "ModifyCollectionViewXib", bundle: nil).instantiate(withOwner: self, options: nil)[0] as? ModifyCollectionView else {
            return
        }
        
        popup.editMode = editMode
        popup.item = currentCollection
        popup.delegate = self
        popup.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        popup.frame = self.view.frame
        self.view.addSubview(popup)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension ModifyCollectionViewController: ModifyCollectionViewDelegate {
    func touchedCancelButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func touchedConfirmButton(color: UIColor, name: String) {
        // 콜렉션 추가 / 수정
        switch editMode {
        case .create:
            excuteAddCollection(collection: AddCollection(title: name, color: "PINK"))
        case .modify:
            excuteModifyCollection(collection: AddCollection(title: name, color: "PINK"), collectionId: currentCollection!.collectionID)
        }
    }
    
    /// 콜렉션 추가
    fileprivate func excuteAddCollection(collection: AddCollection) {
        let statusCode = addCollection(collection: collection)
        switch statusCode {
        case .success:
            print("콜렉션 생성 성공")
            // TODO: 콜렉션 리스트 조회
            NotificationCenter.default.post(name: requestCollectionListNotification, object: nil)
            self.dismiss(animated: true, completion: nil)
        case .fail:
            showAlertController(title: "에러 발생", message: "에러", completionHandler: nil)
        case .server:
            showAlertController()
        }
    }
    
    /// 콜렉션 수정
    fileprivate func excuteModifyCollection(collection: AddCollection, collectionId: Int) {
        print("콜렉션 수정 API 실행")
        let statusCode = modifyCollection(collection: collection, collectionId: collectionId)
        switch statusCode {
        case .success:
            // Singleton에 있는 컬렉션 리스트에 항목 변경
            // TODO: 메인 타이틀 변경
            NotificationCenter.default.post(name: requestCollectionListNotification, object: nil)
            self.dismiss(animated: true, completion: nil)
        case .fail:
            showAlertController(title: "에러 발생", message: "에러", completionHandler: nil)
        case .server:
            showAlertController()
        }
    }
}
