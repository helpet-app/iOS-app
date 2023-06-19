//
//  PetFeaturePageViewModel.swift
//  Helpet
//
//  Created by Efim Nikitin on 17.06.2023.
//

import Foundation
import Combine

final class PetFeaturePageViewModel: ObservableObject {
    private let petFeatureService = PetFeatureService()

    private let pet: Pet

    @Published private(set) var requestStatus: RequestStatus?

    init(pet: Pet) {
        self.pet = pet
    }

    @MainActor
    func deletePetFeature(_ petFeature: PetFeature) async -> Bool {
        self.requestStatus = .loading

        do {
            try await petFeatureService.deletePetFeature(id: petFeature.id, petId: pet.id)

            self.requestStatus = .success
            return true
        } catch {
            self.requestStatus = .failure(error: error)
        }

        return false
    }
}
