//
//  API.swift
//  GankiOSer
//
//  Created by mugua on 2018/9/11.
//  Copyright © 2018年 mugua. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import Alamofire


private let PrettyPicturesEndpointClosure = { (target: PrettyPicturesAPI) -> Endpoint in
    let url = (target.baseURL.absoluteString + target.path).removingPercentEncoding!
    return Endpoint(url: url, sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: target.method, task: target.task, httpHeaderFields: target.headers)
}

private let GankEndpointClosure = { (target: GankIOAPI) -> Endpoint in
    let url = (target.baseURL.absoluteString + target.path).removingPercentEncoding!
    return Endpoint(url: url, sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: target.method, task: target.task, httpHeaderFields: target.headers)
}

/// 获取美图
let PrettyPicturesProvider: RxMoyaProvider = RxMoyaProvider(endpointClosure: PrettyPicturesEndpointClosure)

// 获取gank每日推荐
let GankProvider: RxMoyaProvider = RxMoyaProvider(endpointClosure: GankEndpointClosure)

