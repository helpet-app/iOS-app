//
//  FamilyService.swift
//  Helpet
//
//  Created by Efim Nikitin on 05.06.2023.
//

import Foundation

final class FamilyService {
    private let apiClient = APIClient(baseURL: APIConfig.Service.petServiceURL)

    func getFamilies() async throws -> [Family] {
        return try await apiClient.dispatch(GetFamiliesRequest())
    }

    func getFamiliesMembers() async throws -> [FamilyMember] {
        return try await apiClient.dispatch(GetFamiliesMembersRequest())
    }
}
