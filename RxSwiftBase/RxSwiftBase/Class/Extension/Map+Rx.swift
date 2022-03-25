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
            var  data: Data?
            if let response = response as? Response {
                data = response.data
            }
            if let response = response as? ProgressResponse {
                data = response.response?.data
            }
            
            guard let data = data else {
                throw NetworkError.noData
            }
            
            if type is Codable {
                do {
                    let decoder = JSONDecoder()
                    let dataResponse = try decoder.decode(NBaseDataResponse<T>.self, from: data)
                    return dataResponse
                } catch _ {
                    throw NetworkError.decodingError
                }
                
            } else {
                return NBaseDataResponse<T>.init(json: JSON.init(data: data))
            }
        }
    }
    
    /// 将字典数组转为model数组
    func mapListObject<T: SMappable>(type: T.Type) -> Observable<NBaseListResponse<T>> {
        return self.map { response in
            var  data: Data?
            if let response = response as? Response {
                data = response.data
            }
            if let response = response as? ProgressResponse {
                data = response.response?.data
            }
            
            guard let data = data else {
                throw NetworkError.noData
            }
            
            if type is Codable {
                do {
                    let decoder = JSONDecoder()
                    let dataResponse = try decoder.decode(NBaseListResponse<T>.self, from: data)
                    return dataResponse
                } catch _ {
                    throw NetworkError.decodingError
                }
                
            } else {
                return NBaseListResponse<T>.init(json: JSON.init(data: data))
            }
        }
    }
    
    
    /// 将字典转为model
    func mapObject<T: SMappable>(type: T.Type) -> Observable<T> {
        return self.map { response in
            var  data: Data?
            if let response = response as? Response {
                data = response.data
            }
            if let response = response as? ProgressResponse {
                data = response.response?.data
            }
            
            guard let data = data else {
                throw NetworkError.noData
            }
            
            if type is Codable {
                do {
                    let decoder = JSONDecoder()
                    let dataResponse = try decoder.decode(T.self, from: data)
                    return dataResponse
                } catch _ {
                    throw NetworkError.decodingError
                }
                
            } else {
                return T.init(json: JSON.init(data: data))
            }
        }
    }
    
    /// 将字典数组转为model数组
    func mapArray<T: SMappable>(type: T.Type) -> Observable<[T]> {
        return self.map { response in
            var  data: Data?
            if let response = response as? Response {
                data = response.data
            }
            if let response = response as? ProgressResponse {
                data = response.response?.data
            }
            
            guard let data = data else {
                throw NetworkError.noData
            }
            
            if type is Codable {
                do {
                    let decoder = JSONDecoder()
                    let dataResponse = try decoder.decode([T].self, from: data)
                    return dataResponse
                } catch _ {
                    throw NetworkError.decodingError
                }
                
            } else {
                return JSON.init(data: data).arrayValue.compactMap{ T(json: $0) }
            }
        }
    }
    
}
