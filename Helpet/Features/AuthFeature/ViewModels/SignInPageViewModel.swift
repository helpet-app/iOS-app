//
//  SignInPageViewModel.swift
//  Helpet
//
//  Created by Efim Nikitin on 17.01.2023.
//

import Foundation
import Combine

final class SignInPageViewModel: ObservableObject {
    private let authService = AuthService()

    @Published var signInInfo = SignInInfo()

    @Published private(set) var formIsFilled = false

    @Published private(set) var requestStatus: RequestStatus?

    init() {
        formIsFilledPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: &$formIsFilled)
    }

    @MainActor
    func signInButtonTapped() async {
        self.requestStatus = .loading

        do {
            let requestBody = SignInRequestBody(username: signInInfo.username, password: signInInfo.password)

            try await authService.signIn(body: requestBody)

            self.requestStatus = .success
        } catch {
            self.requestStatus = .failure(error: error)
        }
    }
}

extension SignInPageViewModel {
    private var usernameIsFilledPublisher: AnyPublisher<Bool, Never> {
        $signInInfo
            .map(\.username)
            .removeDuplicates()
            .map { username in
                return !username.isEmpty
            }
            .eraseToAnyPublisher()
    }

    private var passwordIsFilledPublisher: AnyPublisher<Bool, Never> {
        $signInInfo
            .map(\.password)
            .removeDuplicates()
            .map { password in
                return !password.isEmpty
            }
            .eraseToAnyPublisher()
    }

    private var formIsFilledPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(usernameIsFilledPublisher, passwordIsFilledPublisher)
            .map { usernameIsFilled, passwordIsFilled in
                return usernameIsFilled && passwordIsFilled
            }
            .eraseToAnyPublisher()
    }
}
