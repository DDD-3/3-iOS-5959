//
//  SearchItemVC.swift
//  iOS5959
//
//  Created by mong on 2020/02/12.
//  Copyright © 2020 5959. All rights reserved.
//

import Foundation
import UIKit

class SearchItemVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var searchList: Search?
    var itemTitle: String?
    
    @IBOutlet var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchList?.data.searchResults.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as? SearchTableViewCell else {return UITableViewCell()}
        if searchList?.data != nil {
            cell.itemTitleLabel.text = searchList!.data.searchResults[indexPath.row].name
            cell.itemPriceLabel.text = "\(searchList!.data.searchResults[indexPath.row].price)"
            
            let imageURL = URL(string: searchList!.data.searchResults[indexPath.row].imageUrl)
            if let data = try? Data(contentsOf: imageURL!) {
                cell.imageView?.image = UIImage(data: data)
                cell.imageView?.sizeToFit()
            }
        }
        return cell
    }
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        searchRequest(itemTitle: itemTitle ?? "")
    }
    
    private func searchRequest(itemTitle: String){
        // Search API 실행
        print("Search API 실행")
        let statusCode = requestSearchList(itemTitle: itemTitle, completion: {(result) in
            self.searchList = result
        })
        switch statusCode {
        case .success:
            print("Fetch Success")
        case .fail:
            showAlertController(title: "에러 발생", message: "에러 메세지가 위치하는 곳", completionHandler: nil)
        case .server:
            showAlertController()
        }

    }
}
