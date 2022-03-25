//
//  APIService.swift
//  RxSwiftBase
//
//  Created by OFweek01 on 2022/3/23.
//

import Foundation

/* -------------------------- 网络测试 ------------------ */
protocol CustomTargetType: TargetType {
    var timeout: TimeInterval { get }
    var isShowHUD: Bool { get }
    var isShowLog: Bool { get }
    var isShowPlugLog: Bool { get }
}

extension CustomTargetType {
    var timeout: TimeInterval {
        return 15.0
    }
    
    var isShowHUD: Bool {
        return true
    }
    
    var isShowLog: Bool {
#if DEBUG
        return false
#else
        return false
#endif
    }
    
    var isShowPlugLog: Bool {
        return false
    }
}

enum APIService {
    case testGet
}

extension APIService: CustomTargetType {
    var headers: [String : String]? {
        var header = [String: String]()
        header["Content-Type"] = "application/x-www-form-urlencoded"
        //header["Content-Type"] = "application/json;charset=UTF-8"
        return header
    }
    
    var baseURL: URL {
        return URL(string: "http://www.weather.com.cn/data/sk/101010100.html")!
    }
    
    var path: String {
        switch self {
        case .testGet:
            return ""
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        //return .requestPlain
        return .requestParameters(parameters: ["test": "122"], encoding: URLEncoding.default)
    }
    
}
