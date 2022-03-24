//
//  HttpBin.swift
//  RxSwiftBase
//
//  Created by OFweek01 on 2022/3/24.
//

import Foundation

class HttpBin: JSONMappable {
    var args: [String: Any]
    var origin: String
    var url: String

    required init(json: JSON) {
        args = json["args"].dictionaryValue
        origin = json["origin"].stringValue
        url = json["url"].stringValue
    }

}
