//
//  VaccinationPageViewModel.swift
//  Helpet
//
//  Created by Efim Nikitin on 17.06.2023.
//

import Foundation
import Combine

final class VaccinationPageViewModel: ObservableObject {
    private let petVaccinationService = PetVaccinationService()

    private let pet: Pet

    @Published private(set) var requestStatus: RequestStatus?

    init(pet: Pet) {
        self.pet = pet
    }

    @MainActor
    func deletePetVaccination(_ petVaccination: PetVaccination) async -> Bool {
        self.requestStatus = .loading

        do {
            try await petVaccinationService.deletePetVaccination(id: petVaccination.id, petId: pet.id)

            self.requestStatus = .success
            return true
        } catch {
            self.requestStatus = .failure(error: error)
        }

        return false
    }
}
