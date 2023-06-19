//
//  ProfileService.swift
//  Helpet
//
//  Created by Efim Nikitin on 02.05.2023.
//

import Foundation

final class ProfileService {
    private let apiClient = APIClient(baseURL: APIConfig.Service.accountServiceURL)

    func getProfile() async throws -> Profile {
        return try await apiClient.dispatch(GetProfileRequest())
    }

    func updateProfile(body: UpdateProfileRequestBody) async throws -> Profile {
        try body.validate()

        return try await apiClient.dispatch(UpdateProfileRequest(body: body))
    }
}
