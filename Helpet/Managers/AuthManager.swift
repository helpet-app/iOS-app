//
//  AuthManager.swift
//  Helpet
//
//  Created by Efim Nikitin on 02.05.2023.
//

import Foundation

actor AuthManager {
    private let networkDispatcher = NetworkDispatcher()

    private var refreshTask: Task<Void, Error>?

    static let shared = AuthManager()

    private init() {}

    func saveAuth(tokens: Tokens) {
        let accessToken = Token(value: tokens.accessToken, expiresAt: Date(timeIntervalSinceNow: tokens.accessExpiresIn), type: tokens.tokenType)
        let refreshToken = Token(value: tokens.refreshToken, expiresAt: Date(timeIntervalSinceNow: tokens.refreshExpiresIn), type: tokens.tokenType)
        TokenManager.shared.saveAccessToken(token: accessToken)
        TokenManager.shared.saveRefreshToken(token: refreshToken)
        AuthState.shared.isAuthenticated.send(true)
    }

    func removeAuth() {
        TokenManager.shared.deleteAccessToken()
        TokenManager.shared.deleteRefreshToken()
        AuthState.shared.isAuthenticated.send(false)
    }

    func refreshAuthIfNeeded() async throws {
        if let refreshTask = refreshTask {
            return try await refreshTask.value
        }

        do {
            guard let accessToken = TokenManager.shared.getAccessToken() else {
                throw BasicError.missingTokenError
            }

            if refreshIsNeeded(accessToken: accessToken) {
                try await refreshToken()
            }
        } catch {
            let error = BasicError(from: error)
            switch error {
            case .urlSessionError:
                throw error
            default:
                removeAuth()
            }
        }
    }

    private func refreshIsNeeded(accessToken: Token) -> Bool {
        return Date(timeIntervalSinceNow: AuthConfig.accessTokenLifeThreshold) > accessToken.expiresAt
    }

    private func refreshToken() async throws {
        let task = Task {
            defer { refreshTask = nil }

            guard let refreshToken = TokenManager.shared.getRefreshToken() else {
                throw BasicError.missingTokenError
            }

            let request = RefreshTokenRequest(body: RefreshTokenRequestBody(refreshToken: refreshToken.value))
            guard let urlRequest = request.asURLRequest(baseURL: APIConfig.Service.accountServiceURL) else {
                throw BasicError.unknownError
            }

            let tokensResponse: Tokens = try await networkDispatcher.dispatch(request: urlRequest)
            saveAuth(tokens: tokensResponse)
        }

        self.refreshTask = task

        try await task.value
    }
}
