//
//  DiseasePageViewModel.swift
//  Helpet
//
//  Created by Efim Nikitin on 17.06.2023.
//

import Foundation
import Combine

final class DiseasePageViewModel: ObservableObject {
    private let petDiseaseService = PetDiseaseService()

    private let pet: Pet

    @Published private(set) var requestStatus: RequestStatus?

    init(pet: Pet) {
        self.pet = pet
    }

    @MainActor
    func deletePetDisease(_ petDisease: PetDisease) async -> Bool {
        self.requestStatus = .loading

        do {
            try await petDiseaseService.deletePetDisease(id: petDisease.id, petId: pet.id)

            self.requestStatus = .success
            return true
        } catch {
            self.requestStatus = .failure(error: error)
        }

        return false
    }
}
