//
//  PetFeatureService.swift
//  Helpet
//
//  Created by Efim Nikitin on 05.06.2023.
//

import Foundation

final class PetFeatureService {
    private let apiClient = APIClient(baseURL: APIConfig.Service.petServiceURL)

    func getPetFeatures(id: UUID) async throws -> [PetFeature] {
        return try await apiClient.dispatch(GetPetFeaturesRequest(petId: id))
    }

    func createPetFeature(id: UUID, body: CreatePetFeatureRequestBody) async throws -> PetFeature {
        try body.validate()

        return try await apiClient.dispatch(CreatePetFeatureRequest(petId: id, body: body))
    }

    func deletePetFeature(id: UUID, petId: UUID) async throws {
        _ = try await apiClient.dispatch(DeletePetFeatureRequest(petId: petId, featureId: id))
    }
}
