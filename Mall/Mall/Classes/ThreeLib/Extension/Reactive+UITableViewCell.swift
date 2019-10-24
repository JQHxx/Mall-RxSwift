//
//  Reactive+UITableViewCell.swift
//  Mall
//
//  Created by midland on 2019/10/24.
//  Copyright © 2019 JQHxx. All rights reserved.
//

import Foundation

/**
 绑定按钮的点击事件
 */
extension Reactive where Base: UITableViewCell & CellButtonTriggerble{
   
   var trigger: Observable<IndexPath> {
       base.canTrigger = true
       return base.triggerButton.rx.tap.map{[weak cell = self.base] _ in
           if let tb = cell?.superview as? UITableView {
               return tb.indexPath(for: cell!)!
           } else {
               fatalError()
           }
       }
   }
}
