//
//  ViewController.swift
//  GankiOSer
//
//  Created by mugua on 2018/9/10.
//  Copyright © 2018年 mugua. All rights reserved.
//

import UIKit
import SideMenu

class ViewController: UIViewController {
    
   lazy var menuLeftNavigationController: UISideMenuNavigationController = {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "LeftSideMenuController")
        let side = UISideMenuNavigationController(rootViewController: vc)
        return side
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
        SideMenuManager.default.menuPresentMode = .viewSlideInOut
        SideMenuManager.default.menuShadowColor = UIColor.black
        SideMenuManager.default.menuFadeStatusBar = false
        
        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        
    }
    
    @IBAction func leftSideTap(_ sender: UIBarButtonItem) {
        
       present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
    }
}

