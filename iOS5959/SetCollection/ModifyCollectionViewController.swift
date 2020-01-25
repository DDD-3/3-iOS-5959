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
    func touchedBackgroundView() {
        self.dismiss(animated: false, completion: nil)
    }
}
