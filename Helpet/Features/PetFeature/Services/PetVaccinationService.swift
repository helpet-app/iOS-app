//
//  PetVaccinationService.swift
//  Helpet
//
//  Created by Efim Nikitin on 05.06.2023.
//

import Foundation

final class PetVaccinationService {
    private let apiClient = APIClient(baseURL: APIConfig.Service.petServiceURL)

    func getPetVaccinationHistory(id: UUID, pageParams: PageParams) async throws -> PageResponse<PetVaccination> {
        return try await apiClient.dispatch(GetPetVaccinationHistoryRequest(petId: id, pageParams: pageParams))
    }

    func createPetVaccination(id: UUID, body: CreatePetVaccinationRequestBody) async throws -> PetVaccination {
        try body.validate()

        return try await apiClient.dispatch(CreatePetVaccinationRequest(petId: id, body: body))
    }

    func deletePetVaccination(id: UUID, petId: UUID) async throws {
        _ = try await apiClient.dispatch(DeletePetVaccinationRequest(petId: petId, vaccinationId: id))
    }
}
