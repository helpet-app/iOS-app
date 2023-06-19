//
//  PetProfilePageViewModel.swift
//  Helpet
//
//  Created by Efim Nikitin on 26.01.2023.
//

import Foundation

final class PetProfilePageViewModel: ObservableObject {
    private let petService = PetService()

    private let appointmentService = AppointmentService()

    private let petFeatureService = PetFeatureService()

    private let petAnthropometryService = PetAnthropometryService()

    private let petDiseaseService = PetDiseaseService()

    private let petVaccinationService = PetVaccinationService()

    @Published var pet: Pet

    @Published var petMedicalCard: PetMedicalCard?

    @Published var appointmentHistory: [Appointment] = []

    @Published var petFeatures: [PetFeature] = []

    @Published var antropometryHistory: [PetAnthropometry] = []

    @Published var diseaseHistory: [PetDisease] = []

    @Published var vaccinationHistory: [PetVaccination] = []

    @Published private(set) var medicalCardRequestStatus: RequestStatus?

    @Published private(set) var tabsRequestStatuses: [PetProfileTabViewModel.TabType: RequestStatus] = [:]

    @Published private(set) var deleteRequestStatus: RequestStatus?

    init(pet: Pet) {
        self.pet = pet
    }

    func extractPetCategory() -> String? {
        if let category = pet.petCategory, let species = pet.species {
            return "\(species.name), \(category.name)"
        } else if let category = pet.petCategory {
            return category.name
        } else if let species = pet.species {
            return species.name
        }

        return nil
    }

    @MainActor
    func fetchPetMedicalCard() async {
        if medicalCardRequestStatus == nil {
            self.medicalCardRequestStatus = .loading
        }

        do {
            self.petMedicalCard = try await petService.getPetMedicalCard(id: pet.id)
            self.medicalCardRequestStatus = .success
        } catch {
            self.medicalCardRequestStatus = .failure(error: error)
        }
    }

    @MainActor
    func fetchPetAppointmentHistory() async {
        await fetchData(for: .appointmentHistory) {
            self.appointmentHistory = try await self.appointmentService.getPetAppointments(id: self.pet.id, pageParams: PageParams()).content
        }
    }

    @MainActor
    func fetchPetFeatures() async {
        await fetchData(for: .petFeatures) {
            self.petFeatures = try await self.petFeatureService.getPetFeatures(id: self.pet.id)
        }
    }

    @MainActor
    func fetchPetAntropometryHistory() async {
        await fetchData(for: .antropometryHistory) {
            self.antropometryHistory = try await self.petAnthropometryService.getPetAnthropometryHistory(id: self.pet.id, pageParams: PageParams()).content
        }
    }

    @MainActor
    func fetchPetDiseaseHistory() async {
        await fetchData(for: .diseaseHistory) {
            self.diseaseHistory = try await self.petDiseaseService.getPetDiseaseHistory(id: self.pet.id, pageParams: PageParams()).content
        }
    }

    @MainActor
    func fetchPetVaccinationHistory() async {
        await fetchData(for: .vaccinationHistory) {
            self.vaccinationHistory = try await self.petVaccinationService.getPetVaccinationHistory(id: self.pet.id, pageParams: PageParams()).content
        }
    }

    @MainActor
    func deletePet() async -> Bool {
        self.deleteRequestStatus = .loading

        do {
            try await petService.deletePet(id: pet.id)

            self.deleteRequestStatus = .success
            return true
        } catch {
            self.deleteRequestStatus = .failure(error: error)
        }

        return false
    }

    @MainActor
    private func fetchData(for tab: PetProfileTabViewModel.TabType, function: @escaping () async throws -> Void) async {
        if tabsRequestStatuses[tab] == nil {
            self.tabsRequestStatuses[tab] = .loading
        }

        do {
            try await function()

            self.tabsRequestStatuses[tab] = .success
        } catch {
            self.tabsRequestStatuses[tab] = .failure(error: error)
        }
    }
}
