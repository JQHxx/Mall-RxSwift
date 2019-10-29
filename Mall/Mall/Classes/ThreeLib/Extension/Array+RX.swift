//
//  Array+.swift
//  Mall
//
//  Created by midland on 2019/10/29.
//  Copyright © 2019 JQHxx. All rights reserved.
//

import RxDataSources

public extension Array where Element: SectionModelType {
    
    subscript(indexPath: IndexPath) -> Element.Item {
        get {
            return self[indexPath.section].items[indexPath.item]
        }
        mutating set {
            self.update(section: indexPath.section) { items in
                items[indexPath.item] = newValue
            }
        }
    }
    
    mutating func insert(_ newElement: Element.Item, at indexPath: IndexPath) {
        self.update(section: indexPath.section) { items in
            items.insert(newElement, at: indexPath.item)
        }
    }
    
    mutating func insert(_ newElements: [Element.Item], at section: Int) {
        guard self.count > section else { return }
        let remainedCount = self[section].items.count
        for (index, newElement) in newElements.enumerated() {
            self.update(section: section) { items in
                items.insert(newElement, at: remainedCount + index)
            }
        }
    }
    
    @discardableResult
    mutating func remove(at indexPath: IndexPath) -> Element.Item {
        return self.update(section: indexPath.section) { items in
            return items.remove(at: indexPath.item)
        }
    }
    
    mutating func replace(section: Int, items: [Element.Item]) {
        self[section] = Element.init(original: self[section], items: items)
    }
    
    private mutating func update<T>(section: Int, mutate: (inout [Element.Item]) -> T) -> T {
        var items = self[section].items
        let value = mutate(&items)
        self[section] = Element.init(original: self[section], items: items)
        return value
    }
    
}
