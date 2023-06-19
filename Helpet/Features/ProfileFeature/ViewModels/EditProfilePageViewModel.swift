//
//  EditProfilePageViewModel.swift
//  Helpet
//
//  Created by Efim Nikitin on 03.03.2023.
//

import Foundation
import Combine

final class EditProfilePageViewModel: ObservableObject {
    private let profileService = ProfileService()

    @Published var editProfileInfo: EditProfileInfo

    @Published private(set) var formIsFilled = false

    @Published private(set) var requestStatus: RequestStatus?

    init(profile: Profile) {
        self.editProfileInfo = EditProfileInfo(name: profile.name, username: profile.username)

        formIsFilledPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: &$formIsFilled)
    }

    @MainActor
    func updateProfile() async -> Profile? {
        self.requestStatus = .loading

        do {
            let requestBody = UpdateProfileRequestBody(name: editProfileInfo.name, username: editProfileInfo.username)

            let profile = try await profileService.updateProfile(body: requestBody)

            self.requestStatus = .success
            return profile
        } catch {
            self.requestStatus = .failure(error: error)
        }

        return nil
    }
}

extension EditProfilePageViewModel {
    private var nameIsFilledPublisher: AnyPublisher<Bool, Never> {
        $editProfileInfo
            .map(\.name)
            .removeDuplicates()
            .map { name in
                return !name.isEmpty
            }
            .eraseToAnyPublisher()
    }

    private var usernameIsFilledPublisher: AnyPublisher<Bool, Never> {
        $editProfileInfo
            .map(\.username)
            .removeDuplicates()
            .map { username in
                return !username.isEmpty
            }
            .eraseToAnyPublisher()
    }

    private var formIsFilledPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(nameIsFilledPublisher, usernameIsFilledPublisher)
            .map { nameIsFilled, usernameIsFilled in
                return nameIsFilled && usernameIsFilled
            }
            .eraseToAnyPublisher()
    }
}
