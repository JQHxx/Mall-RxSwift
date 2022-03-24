//
//  HUD+Rx.swift
//  RxSwiftBase
//
//  Created by OFweek01 on 2022/3/24.
//

import Foundation
import RxSwift
 

// MARK: - 添加新的Observable类型
extension Observable {
    /// 显示HUD
    public func showHUD(_ isShow: Bool = false) -> Observable<Element> {
        return Observable.create { observer in
            var isEnd = false
            // showHUD
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.4, execute: {
                if isEnd == false && isShow {
                    SVProgressHUD.dismiss()
                    SVProgressHUD.show()
                }
            })
            
            let end = {
                isEnd = true
                // hideHUD
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                }
            }
            
            return self.do(onDispose: {
                end()
            }).subscribe({ event in
                end()
                observer.on(event)
            })
        }
    }
}
