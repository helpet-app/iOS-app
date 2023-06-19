//
//  PetCategoryService.swift
//  Helpet
//
//  Created by Efim Nikitin on 07.06.2023.
//

import Foundation

final class PetCategoryService {
    private let apiClient = APIClient(baseURL: APIConfig.Service.petServiceURL)

    func getPetCategories() async throws -> [PetCategory] {
        return try await apiClient.dispatch(GetPetCategoriesRequest())
    }

    func getCategorySpecies(id: Int, searchName: String? = nil, pageParams: PageParams) async throws -> PageResponse<Species> {
        return try await apiClient.dispatch(GetCategorySpeciesRequest(categoryId: id, searchName: searchName, pageParams: pageParams))
    }
}
