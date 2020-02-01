//
//  WishBallWebView.swift
//  iOS5959
//
//  Created by 최혜선 on 2020/02/01.
//  Copyright © 2020 5959. All rights reserved.
//

import UIKit
import WebKit

protocol WishBallWebViewControllerDelegate: class {
    func chooseItem()
}

class WishBallWebViewController: UIViewController {
    
    weak var delegate: WishBallWebViewControllerDelegate?
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet var webView: WKWebView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var chooseItemButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myURL = URL(string:"https://shopping.naver.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
        commonInit()
    }
    
    @objc private func touchedCloseButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func touchedBackButton(_ sender: UIButton) {
        if webView.canGoBack {
            webView.goBack()
            webView.reload()
        }
    }
    
    @objc private func touchedForwardButton(_ sender: UIButton) {
        if webView.canGoForward {
            webView.goForward()
            webView.reload()
        }
    }
    
    @objc private func touchedRefreshButton(_ sender: UIButton) {
        webView.reload()
    }
    
    @objc private func touchedChooseItemButton(_ sender: UIButton) {
        delegate?.chooseItem()
    }
    
    fileprivate func requestWebPage(url: String?) {
        if let urlString = url, let url = URL(string: urlString) {
            self.webView.load(URLRequest(url: url))
        }
    }
    
    private func commonInit() {
        searchBar.searchTextField.keyboardType = .URL
        searchBar.searchTextField.font = UIFont.nanumRegularFont(ofSize: 17.0)
        searchBar.placeholder = "URL"
        searchBar.delegate = self
        webView.navigationDelegate = self
        chooseItemButton.clipsToBounds = true
        chooseItemButton.layer.cornerRadius = 4.0
        chooseItemButton.setTitleColor(.white, for: .normal)
        chooseItemButton.backgroundColor = .wishBall2
        chooseItemButton.titleLabel?.font = UIFont.nanumHeadlineExtraBold12()
        
        closeButton.addTarget(self, action: #selector(touchedCloseButton(_:)), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(touchedBackButton(_:)), for: .touchUpInside)
        forwardButton.addTarget(self, action: #selector(touchedForwardButton(_:)), for: .touchUpInside)
        refreshButton.addTarget(self, action: #selector(touchedRefreshButton(_:)), for: .touchUpInside)
        chooseItemButton.addTarget(self, action: #selector(touchedChooseItemButton(_:)), for: .touchUpInside)
    }
}

extension WishBallWebViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.requestWebPage(url: searchBar.text)
        self.view.endEditing(true)
    }
}

extension WishBallWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // 현재 웹페이지 URL searchBar에 표시하기
        self.searchBar.text = webView.url?.absoluteString
    }
}
