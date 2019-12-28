//
//  SideMenuViewController.swift
//  iOS5959
//
//  Created by 최혜선 on 2019/12/29.
//  Copyright © 2019 5959. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController {
    
    @IBOutlet fileprivate weak var sideMenuTableView: SideMenuTableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        sideMenuTableView.reloadData()
    }
}
