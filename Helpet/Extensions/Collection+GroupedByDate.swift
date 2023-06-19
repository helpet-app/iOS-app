//
//  Collection+GroupedByDate.swift
//  Helpet
//
//  Created by Efim Nikitin on 18.01.2023.
//

import Foundation

extension Collection {
    func groupedBy(dateComponents: Set<Calendar.Component>, key: KeyPath<Element, Date>) -> [Date: [Element]] {
        let initial: [Date: [Element]] = [:]

        let groupedByDateComponents = reduce(into: initial) { partialResult, currentValue in
            let components = Calendar.current.dateComponents(dateComponents, from: currentValue[keyPath: key])
            let date = Calendar.current.date(from: components)!
            partialResult[date, default: []].append(currentValue)
        }

        return groupedByDateComponents
    }
}
