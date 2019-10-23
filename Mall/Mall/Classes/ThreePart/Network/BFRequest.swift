//
//  Request.swift
//  TextureBase
//
//  Created by HJQ on 2018/12/16.
//  Copyright © 2018 ml. All rights reserved.
//

import UIKit
import Alamofire

enum HTTPRequestMethod: Int {
    case GET = 0
    case POST
}

protocol BFRequest {
    var host: String { get }
    var path: String { get }
    var method: HTTPRequestMethod { get }
    // 请求参数
    var parameters: [String: Any]? { get }
    // 自定义请求头
    var normalHeaders: [String: String] { get }
    var timeOut: TimeInterval { get }
}

extension BFRequest {

    var hud: Bool {
        return false
    }

    var method: HTTPRequestMethod {
        return .POST
    }

    // 服务器的基本地址
    var host: String {
        return API.baseURL
    }
    var normalHeaders: [String: String] {
        // 2.自定义头部
        let headers: [String: String]  = [
            "Accept": "application/json"
        ]
        return headers
    }
    
    var parameters: [String: Any]? {
        var param = [String: Any]()
        let mirror = Mirror(reflecting: self)

        for case let (label?, value) in mirror.children {
            param[label] = value
        }

        return param
    }

    var timeOut: TimeInterval {
        return 15.0
    }

}

