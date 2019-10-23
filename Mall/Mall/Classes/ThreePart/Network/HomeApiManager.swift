//
//  HomeApiManager.swift
//  Mall
//
//  Created by midland on 2019/10/23.
//  Copyright © 2019 JQHxx. All rights reserved.
//

import Foundation
import Moya

enum HomeApiManager {
    case getHomeList(pageIndex: Int, pageSize: Int)
}


extension HomeApiManager: TargetType {
    
    var baseURL: URL{
        return URL(string: API.baseURL)!
    }
    var task: Task{
        return .requestPlain
    }
    var headers: [String : String]?{
        return ["Content-type": "application/json"]
    }
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String{
        switch self{
        case .getHomeList(_, _): return API.homeList
        }
    }
    
    /// The HTTP method used in the request.
    var method: Moya.Method {
        return .post
    }
    
    /// The parameters to be encoded in the request.
    var parameters: [String: Any]? {
        return nil
    }
    
    /// The method used for parameter encoding.
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    /// Provides stub data for use in testing.
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    /// Whether or not to perform Alamofire validation. Defaults to `false`.
    var validate: Bool {
        return false
    }
}
