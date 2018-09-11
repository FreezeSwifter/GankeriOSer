//
//  NetworkMethodImplement.swift
//  GankiOSer
//
//  Created by mugua on 2018/9/11.
//  Copyright © 2018年 mugua. All rights reserved.
//

import Foundation
import Moya

extension PrettyPicturesAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://www.apiopen.top/")!
    }
    
    var path: String {
        return "meituApi"
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data(base64Encoded: "") ?? Data()
    }
    
    var task: Task {
        let requestParameters = parameters ?? [:]
        let encoding: ParameterEncoding = URLEncoding.default
        return .requestParameters(parameters: requestParameters, encoding: encoding)
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .meituApi:
            return ["page": 1]
        }
    }
    
}

extension GankIOAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: "http://gank.io/api/")!
    }
    
    var path: String {
        switch self {
        case .tody:
            return "tody"
        default:
            return ""
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data(base64Encoded: "") ?? Data()
    }
    
    var task: Task {
        let requestParameters = parameters ?? [:]
        let encoding: ParameterEncoding = URLEncoding.default
        return .requestParameters(parameters: requestParameters, encoding: encoding)
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    var parameters: [String: Any]? {
        switch self {
        default: return nil
        }
    }
}
