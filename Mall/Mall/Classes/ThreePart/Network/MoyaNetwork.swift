//
//  MoyaNetwork.swift
//  Mall
//
//  Created by midland on 2019/10/23.
//  Copyright © 2019 JQHxx. All rights reserved.
//

import Foundation
import ObjectMapper
import SwiftyJSON
import Moya

///成功
typealias SuccessStringClosure = (_ result: String) -> Void
typealias SuccessJSONClosure = (_ result: JSON) -> Void
/// 失败
typealias FailureClosure = (_ errorMsg: String?) -> Void

private let failInfo = "解析错误"

enum RequestEroor: Error {
    case otherError(description: String)
}

class MoyaNetwork {
    static let shared = MoyaNetwork()
    private init() {}
    
    /// 请求JSON数据
    func requestDataWithTargetJSON<T: TargetType>(target: T,successClosure: @escaping SuccessJSONClosure, failClosure: @escaping FailureClosure) {
        print(target)
        let requestProvider = MoyaProvider<T>(requestClosure:requestTimeoutClosure(target: target))
        let _ = requestProvider.request(target) { (result) -> () in
            switch result {
            case let .success(response):
                do {
                    let mapjson = try response.mapJSON()
                    let json = JSON(mapjson)
                    successClosure(json)
                } catch {
                    failClosure(failInfo)
                }
            case let .failure(error):
                failClosure(error.errorDescription)
            }
        }
    }
    
    ///请求String数据
    func requestDataWithTargetString<T: TargetType>(target: T,successClosure: @escaping SuccessStringClosure, failClosure: @escaping FailureClosure) {
        let requestProvider = MoyaProvider<T>(requestClosure:requestTimeoutClosure(target: target))
        let _=requestProvider.request(target) { (result) -> () in
            switch result {
            case let .success(response):
                do {
                    let str = try response.mapString()
                    successClosure(str)
                } catch {
                    failClosure(failInfo)
                }
            case let .failure(error):
                failClosure(error.errorDescription)
            }

        }
    }
    
     //设置一个公共请求超时时间
    private func requestTimeoutClosure<T: TargetType>(target: T) -> MoyaProvider<T>.RequestClosure {
        let requestTimeoutClosure = { (endpoint:Endpoint, done: @escaping MoyaProvider<T>.RequestResultClosure) in
            do {
                var request = try endpoint.urlRequest()
                request.timeoutInterval = 30 //设置请求超时时间
                done(.success(request))
            } catch {
                return
            }
        }
        return requestTimeoutClosure
    }
}

extension MoyaNetwork {

    ///请求String数据
    func requestDataWithTargetString<T: TargetType>(target: T) -> Observable<String> {
        
        return Observable<String>.create { (observable) -> Disposable in
            let requestProvider = MoyaProvider<T>(requestClosure:self.requestTimeoutClosure(target: target))
             let _ = requestProvider.request(target) { (result) -> () in
                 switch result {
                 case let .success(response):
                     do {
                         let str = try response.mapString()
                        observable.onNext(str)
                        observable.onCompleted()
                     } catch {
                        observable.onError(RequestEroor.otherError(description: failInfo))
                     }
                 case let .failure(error):
                    observable.onError(error)
                 }
             }
            return Disposables.create {
                
            }
        }

    }
}
