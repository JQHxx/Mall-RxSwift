//
//  ObjectMapper+.swift
//  Mall
//
//  Created by HJQ on 2019/10/23.
//  Copyright © 2019 JQHxx. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import ObjectMapper

extension Observable {
    func mapObject<T: Mappable>(type: T.Type) -> Observable<T> {
        return self.map { response in
            //if response is a dictionary, then use ObjectMapper to map the dictionary
            //if not throw an error
            guard let dict = response as? [String: Any] else {
                throw RxSwiftMoyaError.ParseJSONError
            }

            return Mapper<T>().map(JSON: dict)!
        }
    }

    func mapArray<T: Mappable>(type: T.Type) -> Observable<[T]> {
        return self.map { response in
            //if response is an array of dictionaries, then use ObjectMapper to map the dictionary
            //if not, throw an error
            guard let array = response as? [Any] else {
                throw RxSwiftMoyaError.ParseJSONError
            }

            guard let dicts = array as? [[String: Any]] else {
                throw RxSwiftMoyaError.ParseJSONError
            }

            return Mapper<T>().mapArray(JSONArray: dicts)
        }
    }
}

