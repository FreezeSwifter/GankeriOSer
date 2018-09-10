//
//  BaseNavigationController.swift
//  HeroDemo
//
//  Created by mugua on 2018/8/31.
//  Copyright © 2018年 mugua. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
            navigationBar.prefersLargeTitles = true
            navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.black,
                                                      NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 26)]
        } else {
            UIBarButtonItem.appearance()
                .setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.clear],
                                        for: UIControlState.normal)
            UIBarButtonItem.appearance()
                .setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.clear],
                                        for: UIControlState.highlighted)
        }
        navigationBar.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor : UIColor.black,
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18)
        ]
        navigationBar.tintColor = UIColor.black.withAlphaComponent(0.5)
        
        navigationBar.shadowImage = UIImage()
        navigationBar.layer.shadowColor  = UIColor.clear.cgColor
        navigationBar.isTranslucent = false
        
        self.interactivePopGestureRecognizer?.delegate = self
    }
    
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if self.viewControllers.count == 1 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
}


extension BaseNavigationController: UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        return self.viewControllers.count > 1
    }
}
