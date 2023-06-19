//
//  TokenManager.swift
//  Helpet
//
//  Created by Efim Nikitin on 22.02.2023.
//

import Foundation

final class TokenManager {
    private let keyManager = KeychainManager.shared

    private let account = "helpet.com"

    private let accessTokenKey = "accessToken"

    private let refreshTokenKey = "refreshToken"

    static let shared = TokenManager()

    private init() {}

    func getAccessToken() -> Token? {
        return keyManager.read(service: accessTokenKey, account: account, type: Token.self)
    }

    func getRefreshToken() -> Token? {
        return keyManager.read(service: refreshTokenKey, account: account, type: Token.self)
    }

    func saveAccessToken(token: Token) {
        keyManager.save(token, service: accessTokenKey, account: account)
    }

    func saveRefreshToken(token: Token) {
        keyManager.save(token, service: refreshTokenKey, account: account)
    }

    func deleteAccessToken() {
        keyManager.delete(service: accessTokenKey, account: account)
    }

    func deleteRefreshToken() {
        keyManager.delete(service: refreshTokenKey, account: account)
    }
}
