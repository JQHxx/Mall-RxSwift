//
//  BFDateFormatter.swift
//  Mall
//
//  Created by midland on 2019/10/29.
//  Copyright © 2019 JQHxx. All rights reserved.
//

import Foundation

public struct BFDateFormatter {
    /// yyyy年MM月dd日
    static let `default`: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "yyyy年MM月dd日"
        return f
    }()
    
    /// yyyy-MM-dd
    static let standard: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "yyyy-MM-dd"
        return f
    }()
    
    /// yyyy-MM-dd HH:mm
    static let complete: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "yyyy-MM-dd HH:mm"
        return f
    }()
    
    /// yyyy-MM-dd HH:mm:ss
    static let full: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return f
    }()
}
