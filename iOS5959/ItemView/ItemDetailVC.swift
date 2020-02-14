//
//  ItemDetailVC.swift
//  iOS5959
//
//  Created by mong on 2020/01/05.
//  Copyright © 2020 5959. All rights reserved.
//

import Foundation
import UIKit
import Magnetic

class ItemDetailVC: UIViewController {
    var newItemTitle: String?
    var newItemPrice: String?
    var newItemImportance: Int?
    var selectedItem: SelectedItemModel?
    
    @IBOutlet var confirmBtn: UIButton!
    @IBOutlet var confirmExtensionView: UIView!
    
    @IBAction func confirmBtn(_ sender: Any) {
        let mainVC = self.navigationController?.viewControllers[0] as? ViewController
        let node = Node(text: selectedItem?.selectedItemName, image: UIImage(named: "find"), color: .red, radius: 30)
        mainVC?.magnetic?.addChild(node)
        
        
        selectedItem?.selectedItemImage = UIImage(named: "find")!
        guard let imageData = selectedItem?.selectedItemImage.jpegData(compressionQuality: 1.0) else {
            print("##image Data Transform Failure")
            return
        }
        
        if let selectedItem = selectedItem {
            let addWishItem = AddWishItem(targetCollectionId: Singleton.shared.defaultCollection!.collectionID, name: selectedItem.selectedItemName, importance: newItemImportance!, price: selectedItem.selectedItemPrice, memo: selectedItem.selectedItemMemo, purchasingUrl: selectedItem.selectedItemURL, imageFile: imageData)
            
                let _ = createWishItemBodyData(addWishItem: addWishItem)
            /*
            switch postWishItem(wishItemData: createWishItemBodyData(addWishItem: addWishItem)) {
            case .success:
                print("##PostWistItem Networking Success")
            case .fail:
                print("##PostWishItem Networking Failure")
            case .server:
                print("##PostWishItem Networking Server")
            }
 */
        }else {
            print("##initializing AddWishItem Failure")
        }
 

        self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func trashBtn(_ sender: Any) {
        let alert = UIAlertController(title: "상품삭제", message: "해당 상품을 삭제하시겠습니까?\n복구할 수 없습니다", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "아니오", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "예", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        
    }
    override func viewDidAppear(_ animated: Bool) {
    }
    
    func createWishItemBodyData(addWishItem: AddWishItem) -> Data {
        let boundary = UUID().uuidString
        var body = ""
        
        var parameters = [[String : Any]]()
        func parameterGenerator(key: String, value: String, type: String) -> [String : Any]{
            var param = [String : Any]()
            param.updateValue(key, forKey: "key")
            param.updateValue(value, forKey: "value")
            param.updateValue(type, forKey: "type")
            
            return param
        }
        parameters.append(parameterGenerator(key: "name", value: "\(addWishItem.name)", type: "text"))
        parameters.append(parameterGenerator(key: "importance", value: "\(addWishItem.importance + 1)", type: "text"))
        parameters.append(parameterGenerator(key: "targetCollectionId", value: "\(addWishItem.targetCollectionId)", type: "text"))
        parameters.append(parameterGenerator(key: "memo", value: "\(addWishItem.memo)", type: "text"))
        parameters.append(parameterGenerator(key: "purchasingUrl", value: "www.naver.com", type: "text"))
        parameters.append(parameterGenerator(key: "price", value: "345", type: "text"))
        // append imageFile
        
        for param in parameters {
            let paramName = param["key"]!
              body += "--\(boundary)\r\n"
              body += "Content-Disposition:form-data; name=\"\(paramName)\""
              let paramType = param["type"] as! String
              if paramType == "text" {
                let paramValue = param["value"] as! String
                body += "\r\n\r\n\(paramValue)\r\n"
            }
        }
        body += "--\(boundary)--\r\n";
        guard let postData = body.data(using: .utf8) else {
            return Data()
        }
        
        
        var request = URLRequest(url: URL(string: "http://52.79.90.40:8080/api/wishitems")!,timeoutInterval: Double.infinity)
        
        request.addValue("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJjcnlzdGFsUmltIiwiaWQiOjUsImV4cCI6MTU4MjEyNzA1MSwiaWF0IjoxNTgxNjk1MDUxfQ.WUlARJXHIXrOD8H_KS3DJ1RVWmbHZJuciw9pBikPM7k", forHTTPHeaderField: "Authorization")
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
          print(String(data: data, encoding: .utf8)!)
          
        }

        task.resume()
        
        return postData
    }

    
    func postManTest(add: Data) {
        var semaphore = DispatchSemaphore (value: 0)

        let parameters = [
          [
            "key": "name",
            "value": "testNameOnClient2",
            "type": "text"
          ],
          [
            "key": "importance",
            "value": "4",
            "type": "text"
          ],
          [
            "key": "targetCollectionId",
            "value": "8",
            "type": "text"
          ],
          [
            "key": "memo",
            "value": "ClientTest2",
            "type": "text"
          ],
          [
            "key": "purchasingUrl",
            "value": "www.naver.com",
            "type": "text"
          ],
          [
            "key": "price",
            "value": "1",
            "type": "text"
          ]] as [[String : Any]]

        let boundary = (UUID().uuidString)
        var body = ""
        var error: Error? = nil
        for param in parameters {
          if param["disabled"] == nil {
            let paramName = param["key"]!
            body += "--\(boundary)\r\n"
            body += "Content-Disposition:form-data; name=\"\(paramName)\""
            let paramType = param["type"] as! String
            if paramType == "text" {
              let paramValue = param["value"] as! String
              body += "\r\n\r\n\(paramValue)\r\n"
            } else {

            }
          }
        }
        body += "--\(boundary)--\r\n";
//        let postData = body.data(using: .utf8)
        let postData = add

        
        var request = URLRequest(url: URL(string: "http://52.79.90.40:8080/api/wishitems")!,timeoutInterval: Double.infinity)
        
        request.addValue("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJjcnlzdGFsUmltIiwiaWQiOjUsImV4cCI6MTU4MjEyNzA1MSwiaWF0IjoxNTgxNjk1MDUxfQ.WUlARJXHIXrOD8H_KS3DJ1RVWmbHZJuciw9pBikPM7k", forHTTPHeaderField: "Authorization")
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
          print(String(data: data, encoding: .utf8)!)
          semaphore.signal()
        }

        task.resume()
        semaphore.wait()
    }
}
