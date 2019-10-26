//
//  Home_CTMediator.swift
//  Mall
//
//  Created by HJQ on 2019/10/26.
//  Copyright © 2019 JQHxx. All rights reserved.
//

import Foundation

extension CTMediator {
    
    @objc public func Home_Module_homeViewController(callback: @escaping (String) -> Void) -> UIViewController? {
        let  params = [
            "callback" : callback,
            kCTMediatorParamsKeySwiftTargetModuleName : "Mall"
        ] as [AnyHashable : Any]

        if let vc = self.performTarget("HomeModule", action: "HomeViewContoller", params: params, shouldCacheTarget: false) {
            return vc as? UIViewController
        }
        return nil
    }

    /** 调用OC的类
    @objc public func A_showObjc(callback:@escaping (String) -> Void) -> UIViewController? {
        let callbackBlock = callback as @convention(block) (String) -> Void
        let callbackBlockObject = unsafeBitCast(callbackBlock, to: AnyObject.self)
        let params = ["callback":callbackBlockObject] as [AnyHashable:Any]
        if let viewController = self.performTarget("A", action: "Extension_ViewController", params: params, shouldCacheTarget: false) as? UIViewController {
            return viewController
        }
        return nil
    }
     */
}
