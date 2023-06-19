//
//  PetAnthropometryService.swift
//  Helpet
//
//  Created by Efim Nikitin on 05.06.2023.
//

import Foundation

final class PetAnthropometryService {
    private let apiClient = APIClient(baseURL: APIConfig.Service.petServiceURL)

    func getPetAnthropometryHistory(id: UUID, pageParams: PageParams) async throws -> PageResponse<PetAnthropometry> {
        return try await apiClient.dispatch(GetPetAnthropometryHistoryRequest(petId: id, pageParams: pageParams))
    }

    func createPetAnthropometry(id: UUID, body: CreatePetAnthropometryRequestBody) async throws -> PetAnthropometry {
        try body.validate()

        return try await apiClient.dispatch(CreatePetAnthropometryRequest(petId: id, body: body))
    }

    func deletePetAnthropometry(id: UUID, petId: UUID) async throws {
        _ = try await apiClient.dispatch(DeletePetAnthropometryRequest(petId: petId, anthropometryId: id))
    }
}
