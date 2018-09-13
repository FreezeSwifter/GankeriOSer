//
//  ViewController.swift
//  GankiOSer
//
//  Created by mugua on 2018/9/10.
//  Copyright © 2018年 mugua. All rights reserved.
//

import UIKit
import SideMenu
import SnapKit
import Kingfisher
import RxDataSources
import RxCocoa
import RxSwift
import Hero

class ViewController: UIViewController {
    
    lazy var menuLeftNavigationController: UISideMenuNavigationController = {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "LeftSideMenuController")
        let side = UISideMenuNavigationController(rootViewController: vc)
        return side
    }()
    
    let centeredCollectionViewFlowLayout = CenteredCollectionViewFlowLayout()
    var collectionView: UICollectionView!
    
    var dataSource: RxCollectionViewSectionedReloadDataSource<GankSection>!
    let viewModel = HomeViewModel()
    var networkImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupNavigation()
        setupRx()
    }
    
    func setupRx() {
        // figure out cell
        dataSource = RxCollectionViewSectionedReloadDataSource(configureCell: { (ds, ct, indexpath, item) -> HomeRecommendCell in
            let cell = ct.dequeueReusableCell(withReuseIdentifier: "HomeRecommendCell", for: indexpath) as! HomeRecommendCell
            cell.bkImageView.kf.setImage(with: URL(string: item.url))
            cell.categoryLabel.text = item.fetchTime()
            return cell
        })
        
        Observable.zip(
            collectionView
                .rx
                .itemSelected
            ,collectionView
                .rx
                .modelSelected(MeituModel.self))
            .bind{ [unowned self] indexPath, model in
                
            
                let cell = self.collectionView.cellForItem(at: indexPath) as! HomeRecommendCell
                
                cell.contentView.hero.id = indexPath.item.description
                
                let sb = UIStoryboard.init(name: "Main", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "ShowViewController") as! ShowViewController
                
                vc.id = indexPath.item.description
                if let image = cell.bkImageView.image {
                    vc.image = image
                }
                
                self.navigationController?.pushViewController(vc, animated: true)
            }.disposed(by: rx.disposeBag)
        
        
        let vmInput = HomeViewModel.HomeInput(category: .meituApi)
        let vmOutput = viewModel.transform(input: vmInput)
        
        vmOutput.sections.asDriver().drive(collectionView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
        
    }
    
    func setupNavigation() {
        SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
        SideMenuManager.default.menuPresentMode = .viewSlideInOut
        SideMenuManager.default.menuShadowColor = UIColor.black
        SideMenuManager.default.menuFadeStatusBar = false
        
        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
    }
    
    func setupCollectionView() {
        collectionView = UICollectionView(centeredCollectionViewFlowLayout: centeredCollectionViewFlowLayout)
        collectionView.backgroundColor = UIColor.white
        collectionView.register(UINib(nibName: "HomeRecommendCell", bundle: nil), forCellWithReuseIdentifier: "HomeRecommendCell")
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (maker) in
            maker.edges.equalTo(self.view)
        }
        
        centeredCollectionViewFlowLayout.itemSize = CGSize(
            width: view.bounds.width * 0.8,
            height: view.bounds.height * 0.7
        )
        
        centeredCollectionViewFlowLayout.minimumLineSpacing = 20
        
        // Get rid of scrolling indicators
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    @IBAction func leftSideTap(_ sender: UIBarButtonItem) {
        
//        present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
    }
}

