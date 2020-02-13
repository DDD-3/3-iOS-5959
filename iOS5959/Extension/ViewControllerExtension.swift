//
//  ViewControllerExtension.swift
//  iOS5959
//
//  Created by 최혜선 on 2020/02/12.
//  Copyright © 2020 5959. All rights reserved.
//

import UIKit

extension UIViewController {
    /**
     iOS 기본 AlertController
     - Parameter title: 타이틀 - default is "네트워크 에러"
     - Parameter message: 세부 내용 - default is "인터넷 연결을 확인해주세요"
     */
    func showAlertController(title: String = "네트워크 에러", message: String? = "인터넷 연결을 확인해주세요", completionHandler: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
            completionHandler?(action)
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }

    /// 네/아니오 alert
    func showWarningAlertController(title: String, message: String, completionHandler: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "아니오", style: .cancel, handler: nil)
        let confirmAction = UIAlertAction(title: "예", style: .default) { (action) in
            completionHandler?(action)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        self.present(alertController, animated: false, completion: nil)
    }
}
