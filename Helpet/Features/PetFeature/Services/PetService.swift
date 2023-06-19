//
//  PetService.swift
//  Helpet
//
//  Created by Efim Nikitin on 05.06.2023.
//

import Foundation

final class PetService {
    private let apiClient = APIClient(baseURL: APIConfig.Service.petServiceURL)

    func getPets() async throws -> [Pet] {
        return try await apiClient.dispatch(GetPetsRequest())
    }

    func getPet(id: UUID) async throws -> Pet {
        return try await apiClient.dispatch(GetPetRequest(petId: id))
    }

    func getPetMedicalCard(id: UUID) async throws -> PetMedicalCard {
        return try await apiClient.dispatch(GetPetMedicalCardRequest(petId: id))
    }

    func createPet(body: CreatePetRequestBody) async throws -> Pet {
        try body.validate()

        return try await apiClient.dispatch(CreatePetRequest(body: body))
    }

    func deletePet(id: UUID) async throws {
        _ = try await apiClient.dispatch(DeletePetRequest(petId: id))
    }
}
