//
//  AuthService.swift
//  Helpet
//
//  Created by Efim Nikitin on 22.02.2023.
//

import Foundation

final class AuthService {
    private let apiClient = APIClient(baseURL: APIConfig.Service.accountServiceURL)

    func signUp(body: SignUpRequestBody) async throws {
        try body.validate()

        let tokens = try await apiClient.dispatch(SignUpRequest(body: body))

        await AuthManager.shared.saveAuth(tokens: tokens)
    }

    func signIn(body: SignInRequestBody) async throws {
        try body.validate()

        let tokens = try await apiClient.dispatch(SignInRequest(body: body))

        await AuthManager.shared.saveAuth(tokens: tokens)
    }

    func signOut() async throws {
        do {
            _ = try await apiClient.dispatch(SignOutRequest())
        } catch {
            let error = BasicError(from: error)
            if case .urlSessionError = error {
                throw error
            }
        }

        await AuthManager.shared.removeAuth()
        URLCache.shared.removeAllCachedResponses()
    }
}
