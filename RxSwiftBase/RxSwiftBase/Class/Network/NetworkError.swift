//
//  NetworkError.swift
//  RxSwiftBase
//
//  Created by OFweek01 on 2022/3/23.
//

import Foundation


enum NetworkError: Error, CustomStringConvertible {

    case decodingError
    case responseError
    case noData
    case error(Error)
    case code(Int)
    case networkError

    var description: String {
        switch self {
        case .decodingError:
            return "Decoding Error"
        case .noData:
            return "No Data"
        case .responseError:
            return "Response Error"
        case .error(let err):
            return err.localizedDescription
        case .code(let code):
            return "\(code) Error"
        case .networkError:
            return "Network Error"
        }
    }
}
