//
//  UISegmentedControl+.swift
//  Mall
//
//  Created by midland on 2019/10/29.
//  Copyright © 2019 JQHxx. All rights reserved.
//

import RxSwift
import RxCocoa

extension Reactive where Base: UISegmentedControl {
    public var tap: Observable<Int> {
        return base.rx
            .controlEvent(.valueChanged)
            .flatMap { [weak base] _ -> Observable<Int> in
                guard let `base` = base else { return .empty() }
                return base.rx.selectedSegmentIndex.asObservable() }
    }
}
