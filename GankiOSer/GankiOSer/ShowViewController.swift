//
//  ShowViewController.swift
//  HeroDemo
//
//  Created by mugua on 2018/8/31.
//  Copyright © 2018年 mugua. All rights reserved.
//

import UIKit
import Hero

class ShowViewController: UIViewController {
    
    var id = ""
    
    var color: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = color
        
        self.hero.isEnabled = true
        self.view.hero.id = id
        self.view.hero.modifiers = [.fade, .scale(0.5)]
        
        let button = UIButton(type: .system)
        button.setTitle("关闭", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.center = view.center
        button.sizeToFit()
        button.addTarget(self, action: Selector.buttonTapped, for: .touchUpInside)
        view.addSubview(button)
        
    }
    
    func navigationBarInColor() -> UIColor {
        return color
    }
    
    @objc func goback() {
        self.dismiss(animated: true, completion: nil)
    }
    
}

fileprivate extension Selector {
    static let buttonTapped = #selector(ShowViewController.goback)
}
