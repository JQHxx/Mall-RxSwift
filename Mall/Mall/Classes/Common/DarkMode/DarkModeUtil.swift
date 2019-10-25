//
//  DarkModeUtil.swift
//  Mall
//
//  Created by midland on 2019/10/24.
//  Copyright © 2019 JQHxx. All rights reserved.
//

import Foundation

class DarkModeUtil {
    
    /**
     是否是深色模式
     */
    static func isDartModel() -> Bool {
        if #available(iOS 13.0, *) {
            if UITraitCollection.current.userInterfaceStyle == .dark {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
        
    }
}
