//
//  ImageShowController.swift
//  GankiOSer
//
//  Created by mugua on 2018/9/12.
//  Copyright © 2018年 mugua. All rights reserved.
//

import UIKit

class ImageShowController: UIViewController {
    
    var heroID: String!
    var color: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hero.isEnabled = true
        self.view.hero.id = heroID
        self.view.hero.modifiers = [.fade, .scale(0.5)]
        self.view.backgroundColor = getRandomColor()
    }
    
    private func getRandomColor() -> UIColor {
        //Generate between 0 to 1
        let red:CGFloat = CGFloat(drand48())
        let green:CGFloat = CGFloat(drand48())
        let blue:CGFloat = CGFloat(drand48())
        
        return UIColor(red:red, green: green, blue: blue, alpha: 1.0)
    }
}
