//
//  Log+Rx.swift
//  RxSwiftBase
//
//  Created by OFweek01 on 2022/3/24.
//

import Foundation


extension Observable {
    /// 显示HUD
    public func showLog(_ isShow: Bool = false) -> Observable<Element> {
        return Observable.create { observer in
            return self.do(onDispose: {
            }).subscribe({ event in
                observer.on(event)
                Observable.Log.show(with: event, isShowLog: isShow)
            })
                }
    }
    
    class Log {
        static func show(with event: Event<Element>, isShowLog: Bool) {
            switch event {
            case .next(let response):
                if isShowLog {
                    if let response = response as? Response {
                        debugPrint("request =>" + (response.request?.url?.absoluteString ?? ""))
                        debugPrint("response =>" + (String.init(data: response.data, encoding: String.Encoding.utf8) ?? ""))
                    }
                    
                    if let response = response as? ProgressResponse {
                        debugPrint("request =>" + (response.response?.request?.url?.absoluteString ?? ""))
                        debugPrint("response =>" + (String.init(data: response.response?.data ?? Data(), encoding: String.Encoding.utf8) ?? ""))
                    }
                }
                break
            case .error(let error):
                if isShowLog {
                    debugPrint("error => \(error.localizedDescription)")
                }
                break
            case .completed: break
            }
        }
    }
}


