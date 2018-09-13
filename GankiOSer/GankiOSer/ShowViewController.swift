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
    @IBOutlet weak var displayImageView: UIImageView!
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.displayImageView.image = image
        self.hero.isEnabled = true
        self.view.hero.id = id
        self.view.hero.modifiers = [.fade, .scale(0.5)]
        
    }
    
    @objc func goback() {
        self.dismiss(animated: true, completion: nil)
    }
    
}

fileprivate extension Selector {
    static let buttonTapped = #selector(ShowViewController.goback)
}
