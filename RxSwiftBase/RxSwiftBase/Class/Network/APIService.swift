//
//  APIService.swift
//  RxSwiftBase
//
//  Created by OFweek01 on 2022/3/23.
//

import Foundation
import RxSwift
import Moya

/* -------------------------- 网络测试 ------------------ */
protocol CustomTargetType: TargetType {
    var timeout: TimeInterval { get }
    var isShowHUD: Bool { get }
    var isShowLog: Bool { get }
    var isShowPlugLog: Bool { get }
    
    func request(callbackQueue: DispatchQueue?) -> Single<Response>
    func requestWithProgress(callbackQueue: DispatchQueue?) -> Observable<ProgressResponse>
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
    
    func request(callbackQueue: DispatchQueue? = nil) -> Single<Response> {
        return NetworkTools.request(with: self, callbackQueue: callbackQueue)
    }
    
    func requestWithProgress(callbackQueue: DispatchQueue? = nil) -> Observable<ProgressResponse> {
        return NetworkTools.requestWithProgress(with: self, callbackQueue: callbackQueue)
    }
    
}

enum APIService {
    case testGet
    case testPost(params: [String: Any])
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
        case .testPost(_):
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
