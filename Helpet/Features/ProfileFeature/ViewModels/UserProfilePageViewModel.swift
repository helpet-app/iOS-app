//
//  UserProfilePageViewModel.swift
//  Helpet
//
//  Created by Efim Nikitin on 20.01.2023.
//

import Foundation

final class UserProfilePageViewModel: ObservableObject {
    private let profileService = ProfileService()

    @Published var profile: Profile?

    @Published private(set) var requestStatus: RequestStatus?

    init() {
        self.requestStatus = .loading

        Task {
            await fetchProfile()
        }
    }

    @MainActor
    func fetchProfile() async {
        do {
            let profile = try await profileService.getProfile()

            self.profile = profile
            self.requestStatus = .success
        } catch {
            self.requestStatus = .failure(error: error)
        }
    }
}
