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
                if isShow {
                    Observable.Log.show(with: event, isShowLog: isShow)
                }
            })
                }
    }
    
    class Log {
        static func show(with event: Event<Element>, isShowLog: Bool) {
            switch event {
            case .next(let response):
                if isShowLog {
                    var requestString: String?
                    var data: Data?
                    if let response = response as? Response {
                        requestString = String(describing: response.request)
                        data = response.data
                    }
                    
                    if let response = response as? ProgressResponse {
                        requestString = String(describing: response.response?.request)
                        data = response.response?.data
                    }
                    guard let data = data, let requestString = requestString else {
                        return
                    }
                    
                    debugPrint("request =>" + requestString)
                    debugPrint("response =>" + (String.init(data: data, encoding: String.Encoding.utf8) ?? ""))
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


