//
//  PickerPageViewModel.swift
//  Helpet
//
//  Created by Efim Nikitin on 18.06.2023.
//

import Foundation

protocol PickerPageViewModel: ObservableObject {
    associatedtype Item: Identifiable & Hashable

    var items: [Item] { get }

    var requestStatus: RequestStatus? { get }

    func fetchItems() async
}
