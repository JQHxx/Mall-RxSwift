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

struct LogPlugin: HttpPlugin {
    let targetType: CustomTargetType
    
    func didReceive(_ response: Any?, error: Error?) {
#if DEBUG
        if targetType.isShowPlugLog {
            if let response = response {
                var data: Data?
                if let response = response as? Response {
                    data = response.data
                }
                
                if let response = response as? ProgressResponse {
                    data = response.response?.data
                }
                if let data = data {
                    debugPrint("Response =>" + (String.init(data: data, encoding: String.Encoding.utf8) ?? ""))
                }
            }
            
            if let error = error {
                debugPrint("ERROR => \(error.localizedDescription)")
            }
        }
#endif
        
    }
    
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
#if DEBUG
        if let body = request.httpBody,
           let str = String(data: body, encoding: .utf8) {
            if targetType.isShowPlugLog {
                print("REQUEST body: \(request)")
                print("REQUEST to send: \(str)")
            }
        }
#endif
        return request
    }
    
    func willSend(_ request: RequestType, target: TargetType) {
#if DEBUG
        guard let request = request.request else {
            return
        }
        print("---REQUEST: \(String(describing: request))")
#endif
    }
    
}
