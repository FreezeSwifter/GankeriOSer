//
//  HomeRecommendCell.swift
//  GankiOSer
//
//  Created by mugua on 2018/9/11.
//  Copyright © 2018年 mugua. All rights reserved.
//

import UIKit

class HomeRecommendCell: UICollectionViewCell {

    @IBOutlet weak var bkImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var bkView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        
        dropShadow()
    }
    
    private func dropShadow() {
       
        bkView.layer.shadowColor = UIColor.gray.cgColor
        bkView.layer.shadowOpacity = 0.3
        bkView.layer.shadowOffset = CGSize.init(width: -1, height: 4)
        bkView.layer.shadowRadius = 10

    }

}
