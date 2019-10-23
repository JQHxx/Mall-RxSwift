//
//  MessageRequest.swift
//  Mall
//
//  Created by midland on 2019/10/23.
//  Copyright © 2019 JQHxx. All rights reserved.
//

import Foundation

struct MessageRequest: BFRequest {
    var path: String {
        return API.homeList
    }
}
