//
//  CellButtonTriggerble.swift
//  Mall
//
//  Created by midland on 2019/10/24.
//  Copyright © 2019 JQHxx. All rights reserved.
//

import Foundation

protocol CellButtonTriggerble: NSObjectProtocol {
    var triggerButton: UIButton{ get }
    var canTrigger: Bool{ get set }
}
