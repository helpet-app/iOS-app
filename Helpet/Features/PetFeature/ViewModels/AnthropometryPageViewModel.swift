//
//  AnthropometryPageViewModel.swift
//  Helpet
//
//  Created by Efim Nikitin on 17.06.2023.
//

import Foundation
import Combine

final class AnthropometryPageViewModel: ObservableObject {
    private let petAnthropometryService = PetAnthropometryService()

    private let pet: Pet

    @Published private(set) var requestStatus: RequestStatus?

    init(pet: Pet) {
        self.pet = pet
    }

    @MainActor
    func deletePetAnthropometry(_ petAnthropometry: PetAnthropometry) async -> Bool {
        self.requestStatus = .loading

        do {
            try await petAnthropometryService.deletePetAnthropometry(id: petAnthropometry.id, petId: pet.id)

            self.requestStatus = .success
            return true
        } catch {
            self.requestStatus = .failure(error: error)
        }

        return false
    }
}
