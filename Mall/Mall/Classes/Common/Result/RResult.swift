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

public enum RResult<Success: RSuccessedProtocol, Error: RFailedProtocol> {
    
    case success(Success)
    case failure(Error)
    
    public init(value: Success) {
        self = .success(value)
    }
    
    public init(error: Error) {
        self = .failure(error)
    }
    
}

// 使用示例
struct RSuccess<T>: RSuccessedProtocol {
    var value: T
    init(value: T) {
        self.value = value
    }
}

struct RFailure: RFailedProtocol {
    var error: Error
    init(error: Error) {
        self.error = error
    }
}


enum RResultError {
    case customeError(code: Int, desc: String)
    case otherError(String)
}
extension RResultError: Swift.Error { }

typealias Completion = (_ result: RResult<RSuccess<Any>, RFailure>) -> Void

class TDWNetworkTest {
    
    class func tdw_request(parameters: String, completion: @escaping Completion) {
        if parameters.count > 0 {
            let arr = [String]()
            let successResult = RSuccess<Any>(value: arr)
            completion(RResult(value: successResult))
            
        } else {
            let failResult = RFailure(error: RResultError.otherError(""))
            completion(RResult(error: failResult))
        }
    }
    
}
