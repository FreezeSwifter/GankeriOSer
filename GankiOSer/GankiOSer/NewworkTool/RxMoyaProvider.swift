//
//  RxMoyaProvider.swift
//  GankiOSer
//
//  Created by mugua on 2018/9/11.
//  Copyright © 2018年 mugua. All rights reserved.
//

import Foundation
import Alamofire
import HandyJSON
import Moya
import RxSwift

enum APPCommonError: Error {
    case msg(String)
    
    var msg: String {
        switch self {
        case .msg(let value):
            return value
        }
    }
    
    var localizedDescription: String {
        switch self {
        case .msg(let value):
            return value
        }
    }
}


final class RxMoyaProvider<Target>: MoyaProvider<Target> where Target: TargetType {
    
    private let stubScheduler: SchedulerType?
    
    init(endpointClosure: @escaping EndpointClosure = MoyaProvider.defaultEndpointMapping,
         requestClosure: @escaping RequestClosure = MoyaProvider<Target>.defaultRequestMapping,
         stubClosure: @escaping StubClosure = MoyaProvider.neverStub,
         plugins: [PluginType] = [NetworkLoggerPlugin(verbose: true), LoadingPlugin()],
         stubScheduler: SchedulerType? = nil,
         trackInflights: Bool = false) {
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Manager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 15
        configuration.timeoutIntervalForResource = 15
        let manager = Manager(configuration: configuration)
        manager.startRequestsImmediately = false
        self.stubScheduler = stubScheduler
        
        super.init(endpointClosure: endpointClosure, requestClosure: requestClosure, stubClosure: stubClosure, callbackQueue: nil, manager: manager, plugins: plugins, trackInflights: trackInflights)
    }
    
    func requestMapJSON<E: HandyJSON>(_ token: Target, classType: E.Type) -> Observable<E> {
        
        return self.rx.request(token).asObservable().flatMap { (resp) -> Observable<E> in
            guard let json = try? resp.mapJSON() else {
                return Observable.error(APPCommonError.msg("数据解析失败"))
            }
            
            guard let dict = json as? [String: Any] else {
                return Observable.error(APPCommonError.msg("数据解析失败"))
            }
            
            if let object = E.deserialize(from: dict) {
                return Observable.just(object)
            } else {
                return Observable.error(APPCommonError.msg("数据解析失败"))
            }
        }
    }
    
    func requestMapJSONArray<E: HandyJSON>(_ token: Target, classType: E.Type) -> Observable<[E?]> {
        
        return self.rx.request(token).asObservable().flatMap { (resp) -> Observable<[E?]> in
            guard let json = try? resp.mapJSON() else {
                return Observable.error(APPCommonError.msg("数据解析失败"))
            }
            
            guard let dict = json as? [String: Any] else {
                return Observable.error(APPCommonError.msg("数据解析失败"))
            }
            
            let value = dict["data"] as? [[String: Any]]
            
            if let objects = [E].deserialize(from: value) {
                
                return Observable.just(objects)
            } else {
                return Observable.error(APPCommonError.msg("data字段为空"))
            }
            
        }
    }
    
    func requestWithProgress(_ token: Target) -> Observable<ProgressResponse> {
        return self.rx.requestWithProgress(token)
    }
}
