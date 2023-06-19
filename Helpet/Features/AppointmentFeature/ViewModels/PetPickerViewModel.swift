//
//  PetPickerViewModel.swift
//  Helpet
//
//  Created by Efim Nikitin on 18.06.2023.
//

import Foundation

final class PetPickerViewModel: PickerPageViewModel {
    private let petService = PetService()

    @Published private(set) var items: [Pet] = []

    @Published var selectedItem: Pet?

    @Published private(set) var requestStatus: RequestStatus?

    @MainActor
    func fetchItems() async {
        if requestStatus == nil {
            self.requestStatus = .loading
        }

        do {
            self.items = try await petService.getPets()

            self.requestStatus = .success
        } catch {
            self.requestStatus = .failure(error: error)
        }
    }
}
