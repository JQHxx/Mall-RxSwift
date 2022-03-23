//
//  UILabel+.swift
//  RxSwiftBase
//
//  Created by OFweek01 on 2022/3/23.
//

import RxSwift
import UIKit

extension Reactive where Base: UILabel {

    public var textColor: Binder<UIColor> {
       return Binder(self.base) { (label, color) in
            label.textColor = color
        }
    }

}
