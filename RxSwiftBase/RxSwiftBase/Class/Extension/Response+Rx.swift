//
//  Response+Rx.swift
//  RxSwiftBase
//
//  Created by OFweek01 on 2022/3/28.
//

import Foundation

extension Moya.Response {
    /// 将字典转为model
    func mapDataObject<T: SMappable>(type: T.Type) -> NBaseDataResponse<T>? {
        let  data: Data? = self.data
        guard let data = data else {
            return nil
        }
        return NBaseDataResponse<T>.init(json: JSON.init(data: data))
    }
    
    /// 将字典数组转为model数组
    func mapListObject<T: SMappable>(type: T.Type) -> NBaseListResponse<T>? {
        let  data: Data? = self.data
        guard let data = data else {
            return nil
        }
        return NBaseListResponse<T>.init(json: JSON.init(data: data))
    }
    
    /// 将字典转为model
    func mapObject<T: SMappable>(type: T.Type) -> T? {
        let  data: Data? = self.data
        guard let data = data else {
            return nil
        }
        return T.init(json: JSON.init(data: data))
    }
    
    /// 将字典数组转为model数组
    func mapArray<T: SMappable>(type: T.Type) -> [T]?{
        let  data: Data? = self.data
        guard let data = data else {
            return nil
        }
        return JSON.init(data: data).arrayValue.compactMap{ T(json: $0) }
    }
}
