//
//  TabViewModel.swift
//  Helpet
//
//  Created by Efim Nikitin on 01.02.2023.
//

import Foundation

protocol TabViewModel: ObservableObject {
    associatedtype TabType: Equatable, Hashable

    var tabs: [(label: String, type: TabType)] { get }

    var selectedTab: TabType { get set }

    func switchTab(to newTab: TabType)
}

extension TabViewModel {
    func switchTab(to newTab: TabType) {
        selectedTab = newTab
    }
}
