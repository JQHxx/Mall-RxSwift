//
//  BasePlugin.swift
//  RxSwiftBase
//
//  Created by OFweek01 on 2022/3/24.
//

import Foundation
import Moya

public protocol HttpPlugin: PluginType {
    func didReceive(_ response: Any?, error: Error?)
}

extension HttpPlugin {
    func didReceive(_ response: Any?, error: Error?){}
}

struct BasePlugin: HttpPlugin {
    let targetType: CustomTargetType
    
    func willSend(_ request: RequestType, target: TargetType) {
        if targetType.isShowLog {
            let requestString = request.request?.url?.absoluteString ?? ""
            debugPrint("request  =>" + requestString)
        }
    }
    
    func didReceive(_ response: Any?, error: Error?) {
        if targetType.isShowLog {
            if let response = response {
                if let response = response as? Response {
                    debugPrint("response =>" + (String.init(data: response.data, encoding: String.Encoding.utf8) ?? ""))
                }
                
                if let response = response as? ProgressResponse {
                    debugPrint("response =>" + (String.init(data: response.response?.data ?? Data(), encoding: String.Encoding.utf8) ?? ""))
                }
            }
            
            if let error = error {
                debugPrint("error => \(error.localizedDescription)")
            }
        }

    }
}
