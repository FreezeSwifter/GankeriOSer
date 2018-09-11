//
//  LoadingPlugin.swift
//  Alamofire
//
//  Created by Joey on 15/12/2017.
//

import Foundation
import Moya
import UIKit
import Result
import SVProgressHUD

public class LoadingPlugin: PluginType {
    
    public init() {}
    
    public func willSend(_ request: RequestType, target: TargetType) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        SVProgressHUD.show()
    }
    
    public func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        SVProgressHUD.dismiss(withDelay: 0.5)
    }
}
