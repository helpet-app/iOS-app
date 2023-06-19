//
//  PetDiseaseService.swift
//  Helpet
//
//  Created by Efim Nikitin on 05.06.2023.
//

import Foundation

final class PetDiseaseService {
    private let apiClient = APIClient(baseURL: APIConfig.Service.petServiceURL)

    func getPetDiseaseHistory(id: UUID, pageParams: PageParams) async throws -> PageResponse<PetDisease> {
        return try await apiClient.dispatch(GetPetDiseaseHistoryRequest(petId: id, pageParams: pageParams))
    }

    func createPetDisease(id: UUID, body: CreatePetDiseaseRequestBody) async throws -> PetDisease {
        try body.validate()

        return try await apiClient.dispatch(CreatePetDiseaseRequest(petId: id, body: body))
    }

    func deletePetDisease(id: UUID, petId: UUID) async throws {
        _ = try await apiClient.dispatch(DeletePetDiseaseRequest(petId: petId, diseaseId: id))
    }
}
