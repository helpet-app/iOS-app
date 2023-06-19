//
//  AppState.swift
//  Helpet
//
//  Created by Efim Nikitin on 02.05.2023.
//

import Foundation

class AppState: ObservableObject {
    @Published private(set) var isAuthenticated = AuthState.shared.isAuthenticated.value

    init() {
        AuthState.shared.isAuthenticated
            .receive(on: DispatchQueue.main)
            .assign(to: &$isAuthenticated)
    }
}
