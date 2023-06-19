//
//  SettingsPageViewModel.swift
//  Helpet
//
//  Created by Efim Nikitin on 02.05.2023.
//

import Foundation

final class SettingsPageViewModel: ObservableObject {
    private let authService = AuthService()

    @Published private(set) var requestStatus: RequestStatus?

    @MainActor
    func signOutButtonTapped() async {
        self.requestStatus = .loading

        do {
            try await authService.signOut()
            self.requestStatus = .success
        } catch {
            self.requestStatus = .failure(error: error)
        }
    }
}
