//
//  Sequence+SortedByKeyPath.swift
//  Helpet
//
//  Created by Efim Nikitin on 10.06.2023.
//

import Foundation

extension Sequence {
    func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>, using comparator: (T, T) -> Bool = (<)) -> [Element] {
        sorted { lhs, rhs in
            comparator(lhs[keyPath: keyPath], rhs[keyPath: keyPath])
        }
    }
}
