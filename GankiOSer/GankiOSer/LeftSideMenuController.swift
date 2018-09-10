//
//  LeftSideMenuController.swift
//  GankiOSer
//
//  Created by mugua on 2018/9/10.
//  Copyright © 2018年 mugua. All rights reserved.
//

import UIKit

class LeftSideMenuController: UIViewController {

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
