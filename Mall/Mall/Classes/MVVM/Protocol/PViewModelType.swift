//
//  PViewModelType.swift
//  Mall
//
//  Created by midland on 2019/10/23.
//  Copyright © 2019 JQHxx. All rights reserved.
//

import Foundation

protocol PViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
