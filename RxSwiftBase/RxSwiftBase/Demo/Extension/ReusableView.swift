//
//  ReusableView.swift
//  RxSwiftBase
//
//  Created by OFweek01 on 2022/8/4.
//

import Foundation
import UIKit

public protocol ReusableView: AnyObject {
    static var reuseId: String { get }
}

extension ReusableView {
    public static var reuseId: String {
        String(describing: self)
    }
}

extension UITableViewCell : ReusableView {}
extension UICollectionViewCell : ReusableView {}
extension UITableViewHeaderFooterView: ReusableView {}
