//
//  CommonAPI.swift
//  ML
//
//  Created by HJQ on 2019/3/22.
//  Copyright © 2019 杨帅. All rights reserved.
//

import UIKit

import Moya

enum CommonAPI {
    case commonRequest(r: BFRequest)
    case uploadFileRequest(r: BFRequest)
}

extension CommonAPI: TargetType {
    var task: Task {
        switch self {
        case let .commonRequest(r):
            debugPrint("请求参数 => \(r.parameters ?? [:])")
            return .requestParameters(parameters: r.parameters ?? [:], encoding: URLEncoding.default)
        case .uploadFileRequest(let r):
            let params = r.parameters ?? [:]
            var datas = [MultipartFormData]()
            for (key, value) in params {
                if let tempData = value as? Data {
                    let fileName = key + ".png"
                    let formData = MultipartFormData(provider: .data(tempData), name: key, fileName: fileName, mimeType: "image/jpeg")
                    datas.append(formData)
                    
                } else if let imageDict = value as? [String: Data] { // 图片
                    for (imageKey, imageData) in imageDict {
                        let fileName = imageKey + ".png"
                        let formData = MultipartFormData(provider: .data(imageData), name: imageKey, fileName: key + fileName, mimeType: "image/jpeg")
                        datas.append(formData)
                    }
                } else {
                    assert(value is String)
                    let utf8Value = (value as AnyObject).data(using: String.Encoding.utf8.rawValue)!
                    let formData = MultipartFormData(provider: .data(utf8Value), name: key)
                    datas.append(formData)
                }
            }
            return .uploadMultipart(datas)
        }
    }

    ///请求头信息
    var headers: [String : String]? {
        switch self {
        case let .commonRequest(r):
            return r.normalHeaders
        case .uploadFileRequest(let r):
            return r.normalHeaders
        }
    }

    var baseURL: URL {
        switch self {
        case let .commonRequest(r):
            return URL(string: r.host)!
        case .uploadFileRequest(let r):
            return URL(string: r.host)!
        }

    }

    var path: String {
        
        switch self {
        case let .commonRequest(r):
            debugPrint("请求链接=>\(r.host)\(r.path)")
            return r.path
        case .uploadFileRequest(let r):
            debugPrint("请求链接=>\(r.host)\(r.path)")
            return r.path
        }
    }

    var method: Moya.Method {
        switch self {
        case let .commonRequest(r):
            return r.method == .GET ? .get : .post
        case .uploadFileRequest(let r):
            return r.method == .GET ? .get : .post
        }
    }


    ///单元测试用
    public var sampleData:Data {
        return "".data(using:.utf8)!
    }
}
