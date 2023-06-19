//
//  PetCategoryPickerViewModel.swift
//  Helpet
//
//  Created by Efim Nikitin on 07.06.2023.
//

import Foundation

final class PetCategoryPickerViewModel: PickerPageViewModel {
    private let petCategoryService = PetCategoryService()

    @Published private(set) var items: [PetCategory] = []

    @Published var selectedItem: PetCategory?

    @Published private(set) var requestStatus: RequestStatus?

    @MainActor
    func fetchItems() async {
        if requestStatus == nil {
            self.requestStatus = .loading
        }

        do {
            self.items = try await petCategoryService.getPetCategories()

            self.requestStatus = .success
        } catch {
            self.requestStatus = .failure(error: error)
        }
    }
}
