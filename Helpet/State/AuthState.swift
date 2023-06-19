//
//  AuthState.swift
//  Helpet
//
//  Created by Efim Nikitin on 02.05.2023.
//

import Foundation
import Combine

class AuthState {
    private(set) var isAuthenticated = CurrentValueSubject<Bool, Never>(TokenManager.shared.getAccessToken() != nil)

    static let shared = AuthState()

    private init() {}
}
