//
//  RResult.swift
//  Mall
//
//  Created by midland on 2019/10/25.
//  Copyright © 2019 JQHxx. All rights reserved.
//

import Foundation

public protocol RSuccessedProtocol {

}

public protocol RFailedProtocol {
    
}

public enum RResult<T: RSuccessedProtocol, Error: RFailedProtocol> {
    
    case success(T)
    case failure(Error)
    
    public init(value: T) {
        self = .success(value)
    }
    
    public init(error: Error) {
        self = .failure(error)
    }
    
}

// 使用示例
struct RSuccess: RSuccessedProtocol {
    var value: [String]
    init(value: [String]) {
        self.value = value
    }
}

struct RFailure: RFailedProtocol {
    
}

typealias Completion = (_ result: RResult<RSuccess, RFailure>) -> Void

class TDWNetworkTest {
    
    class func tdw_request(parameters: String, completion: @escaping Completion) {
        if parameters.count > 0 {
            let arr = [String]()
            let successResult = RSuccess(value: arr)
            completion(RResult(value: successResult))
            
        } else {
            let failResult = RFailure()
            completion(RResult(error: failResult))
        }
    }
    
}
