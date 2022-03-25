//
//  NBaseDataResponse.swift
//  RxSwiftBase
//
//  Created by OFweek01 on 2022/3/25.
//

import Foundation

struct NBaseDataResponse<T: SMappable>: SMappable {

    var code: Int?
    var message: String?
    var data: T?
    
    init(json: JSON) {
        code = json["code"].intValue
        message = json["message"].stringValue
        data = T.init(json: json["data"])
    }
}

struct NBaseListResponse<T: SMappable>: SMappable {
    var code: Int?
    var message: String?
    var data: [T]?
    
    init(json: JSON) {
        code = json["code"].intValue
        message = json["message"].stringValue
        data = json["data"].arrayValue.compactMap{ T(json: $0) }
    }
}
