//
//  SheetMenuViewModel.swift
//  Helpet
//
//  Created by Efim Nikitin on 26.01.2023.
//

import Foundation

protocol SheetMenuViewModel: ObservableObject {
    associatedtype SheetType: Identifiable

    var imageName: String { get }

    var sheets: [(label: String, imageName: String, type: SheetType)] { get }

    var selectedSheet: SheetType? { get set }

    func switchSheet(to newSheet: SheetType)
}

extension SheetMenuViewModel {
    func switchSheet(to newSheet: SheetType) {
        selectedSheet = newSheet
    }
}
