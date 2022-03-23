//
//  NetworkTools.swift
//  RxSwiftBase
//
//  Created by OFweek01 on 2022/3/23.
//

import Foundation
import Moya

class NetworkTools {
    
    static func request<T: TargetType>(with target: T) -> Single<Response> {
        return MoyaProvider<T>().rx.request(target)
    }
    
    static func request<T: TargetType>(with target: T) -> Observable<ProgressResponse> {
        return MoyaProvider<T>().rx.requestWithProgress(target)
    }
}
