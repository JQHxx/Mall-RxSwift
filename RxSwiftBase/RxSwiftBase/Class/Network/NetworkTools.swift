//
//  NetworkTools.swift
//  RxSwiftBase
//
//  Created by OFweek01 on 2022/3/23.
//

import Foundation
import Moya
import Alamofire
import RxSwift

struct NetworkTools<T: CustomTargetType> {
    // 普通的网络请求
    static func request(with target: T, callbackQueue: DispatchQueue? = nil) -> Observable<Response> {
        // 检验网络
        if !checkNetWorkStatus() {
            return Observable<Response>.create { observer in
                observer.onError(NetworkError.networkError)
                return Disposables.create {}
            }
        }
        //设置请求超时时间
        let requestTimeoutClosure = requestTimeoutClosure(with: target)
        let plugins: [HttpPlugin] = [LogPlugin(targetType: target)]
        let provider = MoyaProvider<T>(requestClosure: requestTimeoutClosure, plugins: plugins)
        var single = Observable<Response>.create { observer in
            let disposable = provider.rx.request(target, callbackQueue: callbackQueue)
                .asObservable()
                .showHUD(target.isShowHUD)
                .showLog(target.isShowLog)
                .subscribe { response in
                    plugins.forEach {$0.didReceive(response, error: nil)}
                    observer.onNext(response)
                    observer.onCompleted()
                } onError: { error in
                    if (error as NSError).code != NSURLErrorCancelled {
                        plugins.forEach {$0.didReceive(nil, error: error)}
                        observer.onError(error)
                    }
                }
            return Disposables.create {
                disposable.dispose()
            }
        }
        
        if target.retry > 0 {
            single = single.retry(target.retry)
        }
        return single.share(replay: 1, scope: .forever)
    }
}

extension NetworkTools {
    // 带进度的请求
    static func requestWithProgress(with target: T, callbackQueue: DispatchQueue? = nil) -> Observable<ProgressResponse> {
        // 检验网络
        if !checkNetWorkStatus() {
            return Observable<ProgressResponse>.create { observable in
                observable.onError(NetworkError.networkError)
                return Disposables.create {}
            }
        }

        // 设置请求超时时间
        let requestTimeoutClosure = requestTimeoutClosure(with: target)
        let plugins: [HttpPlugin] = [LogPlugin(targetType: target)]
        let provider = MoyaProvider<T>(requestClosure: requestTimeoutClosure, plugins: plugins)
        var single = Observable<ProgressResponse>.create { observable in
            let disposable = provider.rx.requestWithProgress(target, callbackQueue: callbackQueue)
                .asObservable()
                .showHUD(target.isShowHUD)
                .showLog(target.isShowLog)
                .subscribe { event in
                    switch event {
                    case .next(let element):
                        plugins.forEach {$0.didReceive(element, error: nil)}
                        observable.onNext(element)
                        break
                    case .error(let error):
                        if (error as NSError).code != NSURLErrorCancelled {
                            plugins.forEach {$0.didReceive(nil, error: error)}
                            observable.onError(error)
                        }
                        break
                    case .completed:
                        observable.onCompleted()
                        break
                    }
                }
            return Disposables.create {
                disposable.dispose()
            }
        }
        if target.retry > 0 {
            single = single.retry(target.retry)
        }
        return single.share(replay: 1, scope: .forever)
    }
}

extension NetworkTools {
    // MARK: - 设置请求超时时间
    private static func requestTimeoutClosure(with target: T) -> MoyaProvider<T>.RequestClosure{
        let requestTimeoutClosure = { (endpoint:Endpoint, closure: @escaping MoyaProvider<T>.RequestResultClosure) in
            do {
                var urlRequest = try endpoint.urlRequest()
                urlRequest.timeoutInterval = target.timeout //设置请求超时时间
                closure(.success(urlRequest))
            } catch MoyaError.requestMapping(let url) {
                closure(.failure(MoyaError.requestMapping(url)))
            } catch MoyaError.parameterEncoding(let error) {
                closure(.failure(MoyaError.parameterEncoding(error)))
            } catch {
                closure(.failure(MoyaError.underlying(error, nil)))
            }
        }
        return requestTimeoutClosure
    }
}

extension NetworkTools {
    // MARK:- 检测网络状态
    static func checkNetWorkStatus() -> Bool {
        guard let reach = NetworkReachabilityManager.init(host: "https://www.baidu.com") else {
            return false
        }
        return reach.isReachable
    }
}
