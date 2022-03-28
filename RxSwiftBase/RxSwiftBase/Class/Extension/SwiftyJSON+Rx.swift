//
//  Map+Rx.swift
//  RxSwiftBase
//
//  Created by OFweek01 on 2022/3/25.
//

import Foundation
import Moya

extension Observable {
    
    /// 将字典转为model
    func mapDataObject<T: SMappable>(type: T.Type) -> Observable<NBaseDataResponse<T>> {
        return self.map { response in
            if let dict = response as? [String: Any] {
                return NBaseDataResponse<T>.init(json: JSON.init(dict))
            } else if let response = response as? Moya.Response {
                let data: Data? = response.data
                guard let data = data else {
                    throw NetworkError.noData
                }
                return NBaseDataResponse<T>.init(json: JSON.init(data: data))
                
            } else {
                throw NetworkError.noData
            }
        }
    }
    
    /// 将字典数组转为model数组
    func mapListObject<T: SMappable>(type: T.Type) -> Observable<NBaseListResponse<T>> {
        return self.map { response in
            if let dict = response as? [String: Any] {
                return NBaseListResponse<T>.init(json: JSON.init(dict))
            } else if let response = response as? Moya.Response {
                let data: Data? = response.data
                guard let data = data else {
                    throw NetworkError.noData
                }
                return NBaseListResponse<T>.init(json: JSON.init(data: data))
                
            } else {
                throw NetworkError.noData
            }
        }
    }
    
    /// 将字典转为model
    func mapObject<T: SMappable>(type: T.Type) -> Observable<T> {
        return self.map { response in
            if let dict = response as? [String: Any] {
                return T.init(json: JSON.init(dict))
            } else if let response = response as? Moya.Response {
                let data: Data? = response.data
                guard let data = data else {
                    throw NetworkError.noData
                }
                return T.init(json: JSON.init(data: data))
                
            } else {
                throw NetworkError.noData
            }
        }
    }
    
    /// 将字典数组转为model数组
    func mapArray<T: SMappable>(type: T.Type) -> Observable<[T]> {
        return self.map { response in
            if let array = response as? [Any] {
                return JSON.init(array).arrayValue.compactMap{ T(json: $0) }
            } else if let response = response as? Moya.Response {
                let data: Data? = response.data
                guard let data = data else {
                    throw NetworkError.noData
                }
                return JSON.init(data: data).arrayValue.compactMap{ T(json: $0) }
                
            } else {
                throw NetworkError.noData
            }
        }
    }
    
}
