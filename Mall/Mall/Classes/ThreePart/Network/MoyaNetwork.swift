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
typealias SuccessModelClosure = (_ result: Mappable?) -> Void
typealias SuccessArrModelClosure = (_ result: [Mappable]?) -> Void
/// 失败
typealias FailureClosure = (_ errorMsg: String?) -> Void

private let ParseJSONErrorMes = "解析出错"

enum RxSwiftMoyaError {
    case ParseJSONError
    case OtherError(description: String)
}

extension RxSwiftMoyaError: Swift.Error { }



class MoyaNetwork {
    static let shared = MoyaNetwork()
    private init() {}
    
    /// 请求JSON数据
    func requestDataWithTargetJSON<T: TargetType>(target: T, successClosure: @escaping SuccessJSONClosure, failClosure: @escaping FailureClosure) {
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
                    failClosure(ParseJSONErrorMes)
                }
            case let .failure(error):
                failClosure(error.errorDescription)
            }
        }
    }

    /// 请求数组对象JSON数据
     func requestDataWithTargetArrModelJSON<T: TargetType, M: Mappable>(target: T, model: M, successClosure:@escaping SuccessArrModelClosure,failClosure: @escaping FailureClosure) {
         let requestProvider = MoyaProvider<T>(requestClosure:requestTimeoutClosure(target: target))
         let _=requestProvider.request(target) { (result) -> () in
             switch result {
             case let .success(response):
                 do {
                     let json = try response.mapJSON()
                     let arr = Mapper<M>().mapArray(JSONObject:JSON(json).object)
                     successClosure(arr)
                 } catch {
                     failClosure(ParseJSONErrorMes)
                 }
             case let .failure(error):
                 failClosure(error.errorDescription)
             }
         }
     }
     /// 请求对象JSON数据
     func requestDataWithTargetModelJSON<T:TargetType,M:Mappable>(target:T,model:M,successClosure:@escaping SuccessModelClosure,failClosure: @escaping FailureClosure) {
         let requestProvider = MoyaProvider<T>(requestClosure:requestTimeoutClosure(target: target))
         let _=requestProvider.request(target) { (result) -> () in
             switch result {
             case let .success(response):
                 do {
                     let json = try response.mapJSON()
                     let model=Mapper<M>().map(JSONObject:JSON(json).object)
                     successClosure(model)
                 } catch {
                     failClosure(ParseJSONErrorMes)
                 }
             case let .failure(error):
                 failClosure(error.errorDescription)
             }
         }
     }
    
    ///请求String数据
    func requestDataWithTargetString<T: TargetType>(target: T, successClosure: @escaping SuccessStringClosure, failClosure: @escaping FailureClosure) {
        let requestProvider = MoyaProvider<T>(requestClosure:requestTimeoutClosure(target: target))
        let _=requestProvider.request(target) { (result) -> () in
            switch result {
            case let .success(response):
                do {
                    let str = try response.mapString()
                    successClosure(str)
                } catch {
                    failClosure(ParseJSONErrorMes)
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

    /// 请求JSON数据
    func requestDataWithTargetJSON<T: TargetType>(target: T) -> Observable<JSON>  {
        return Observable.create { (observable) -> Disposable in
            let requestProvider = MoyaProvider<T>(requestClosure:self.requestTimeoutClosure(target: target))
            let _ = requestProvider.request(target) { (result) -> () in
                switch result {
                case let .success(response):
                    do {
                        let mapjson = try response.mapJSON()
                        let json = JSON(mapjson)
                        observable.onNext(json)
                        observable.onCompleted()
                    } catch {
                        observable.onError(RxSwiftMoyaError.OtherError(description: ParseJSONErrorMes))
                    }
                case let .failure(error):
                    observable.onError(error)
                }
            }
            return Disposables.create{}
        }

    }

    ///请求String数据
    func requestDataWithTargetString<T: TargetType>(target: T) -> Observable<String> {
        
        return Observable.create { (observable) -> Disposable in
            let requestProvider = MoyaProvider<T>(requestClosure:self.requestTimeoutClosure(target: target))
             let _ = requestProvider.request(target) { (result) -> () in
                 switch result {
                 case let .success(response):
                     do {
                         let str = try response.mapString()
                        observable.onNext(str)
                        observable.onCompleted()
                     } catch {
                        observable.onError(RxSwiftMoyaError.OtherError(description: ParseJSONErrorMes))
                     }
                 case let .failure(error):
                    observable.onError(error)
                 }
             }
            return Disposables.create{}
        }

    }
}

extension MoyaNetwork {
    /// 请求数组对象JSON数据
        func requestDataWithTargetArrModelJSON<T: TargetType, M: Mappable>(target: T, model: M) -> Observable<[Mappable]?>{

            return Observable.create { (observable) -> Disposable in
                let requestProvider = MoyaProvider<T>(requestClosure:self.requestTimeoutClosure(target: target))
                  let _=requestProvider.request(target) { (result) -> () in
                      switch result {
                      case let .success(response):
                          do {
                              let json = try response.mapJSON()
                              let array = Mapper<M>().mapArray(JSONObject:JSON(json).object)
                              observable.onNext(array)
                              observable.onCompleted()
                          } catch {
                            observable.onError(RxSwiftMoyaError.OtherError(description: ParseJSONErrorMes))
                          }
                      case let .failure(error):
                          observable.onError(error)
                      }
                  }
                return Disposables.create{}
            }

        }
        /// 请求对象JSON数据
        func requestDataWithTargetModelJSON<T: TargetType, M: Mappable>(target: T,model: M) -> Observable<Mappable?> {
            return Observable.create { (observable) -> Disposable in
                let requestProvider = MoyaProvider<T>(requestClosure:self.requestTimeoutClosure(target: target))
                let _=requestProvider.request(target) { (result) -> () in
                    switch result {
                    case let .success(response):
                        do {
                            let json = try response.mapJSON()
                            let model = Mapper<M>().map(JSONObject: JSON(json).object)
                            observable.onNext(model)
                            observable.onCompleted()
                        } catch {
                            observable.onError(RxSwiftMoyaError.OtherError(description: ParseJSONErrorMes))
                        }
                    case let .failure(error):
                        observable.onError(error)
                    }
                }
                return Disposables.create{}
            }


        }
}
