//
//  APIService.swift
//  RxSwiftBase
//
//  Created by OFweek01 on 2022/3/23.
//

import Foundation

/* -------------------------- 网络测试 ------------------ */

enum APIService {
    case testGet
}

extension APIService: TargetType {
    var headers: [String : String]? {
        nil
    }
    

    var baseURL: URL {
        return URL(string: "https://httpbin.org/")!
    }

    var path: String {
        switch self {
        case .testGet:
            return "get"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var parameters: [String: Any]? {
        return nil
    }

    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }

    var sampleData: Data {
        return "".data(using: .utf8)!
    }

    var task: Task {
        return .requestPlain
    }
}
