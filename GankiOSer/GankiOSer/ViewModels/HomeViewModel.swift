//
//  HomeViewModel.swift
//  GankiOSer
//
//  Created by mugua on 2018/9/11.
//  Copyright © 2018年 mugua. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

struct GankSection {
    
    var items: [Item]
}

extension GankSection: SectionModelType {
    
    typealias Item = MeituModel
    
    init(original: GankSection, items: [GankSection.Item]) {
        self = original
        self.items = items
    }
}


protocol GankViewModelType {
    
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

class HomeViewModel: NSObject {
    
    let models = BehaviorRelay<[MeituModel?]>(value: [])
}

extension HomeViewModel: GankViewModelType {
    
    struct HomeInput {
        
        let category: PrettyPicturesAPI
        
        init(category: PrettyPicturesAPI) {
            self.category = category
        }
    }
    
    struct HomeOutput {
        
        let sections: Driver<[GankSection]>
        
        init(sections: Driver<[GankSection]>) {
            self.sections = sections
        }
    }
    
    typealias Input = HomeInput
    
    typealias Output = HomeOutput
    
    func transform(input: HomeViewModel.HomeInput) -> HomeViewModel.HomeOutput {
        
        let sections = models.asObservable().map { (models) -> [GankSection] in
            // 当models的值被改变时会调用
            let m = models.compactMap { $0 }
            
            return [GankSection(items: m)]
            }.asDriver(onErrorJustReturn: [])
        
        let output = HomeOutput(sections: sections)
        
        PrettyPicturesProvider.requestMapJSONArray(input.category, classType: MeituModel.self).subscribe(onNext: {[weak self] (items) in
            
            self?.models.accept(items)
        
        }).disposed(by: rx.disposeBag)
        
        return output
    }

}
