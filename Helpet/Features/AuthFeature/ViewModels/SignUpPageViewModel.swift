//
//  SignUpPageViewModel.swift
//  Helpet
//
//  Created by Efim Nikitin on 17.01.2023.
//

import Foundation
import Combine

final class SignUpPageViewModel: ObservableObject {
    private let authService = AuthService()

    @Published var signUpInfo = SignUpInfo()

    @Published private(set) var formIsFilled = false

    @Published private(set) var requestStatus: RequestStatus?

    init() {
        formIsFilledPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: &$formIsFilled)
    }

    @MainActor
    func signUpButtonTapped() async {
        self.requestStatus = .loading

        do {
            let requestBody = SignUpRequestBody(name: signUpInfo.name,
                                                email: signUpInfo.email,
                                                username: signUpInfo.username,
                                                password: signUpInfo.password)

            try await authService.signUp(body: requestBody)

            self.requestStatus = .success
        } catch {
            self.requestStatus = .failure(error: error)
        }
    }
}

extension SignUpPageViewModel {
    private var nameIsFilledPublisher: AnyPublisher<Bool, Never> {
        $signUpInfo
            .map(\.name)
            .removeDuplicates()
            .map { fullName in
                return !fullName.isEmpty
            }
            .eraseToAnyPublisher()
    }

    private var emailIsFilledPublisher: AnyPublisher<Bool, Never> {
        $signUpInfo
            .map(\.email)
            .removeDuplicates()
            .map { email in
                return !email.isEmpty
            }
            .eraseToAnyPublisher()
    }

    private var usernameIsFilledPublisher: AnyPublisher<Bool, Never> {
        $signUpInfo
            .map(\.username)
            .removeDuplicates()
            .map { username in
                return !username.isEmpty
            }
            .eraseToAnyPublisher()
    }

    private var passwordIsFilledPublisher: AnyPublisher<Bool, Never> {
        $signUpInfo
            .map(\.password)
            .removeDuplicates()
            .map { password in
                return !password.isEmpty
            }
            .eraseToAnyPublisher()
    }

    private var confirmPasswordIsFilledPublisher: AnyPublisher<Bool, Never> {
        $signUpInfo
            .map(\.confirmPassword)
            .removeDuplicates()
            .map { confirmPassword in
                return !confirmPassword.isEmpty
            }
            .eraseToAnyPublisher()
    }

    private var passwordsMatchPublisher: AnyPublisher<Bool, Never> {
        $signUpInfo
            .map(\.password, \.confirmPassword)
            .removeDuplicates { lhs, rhs in
                return lhs.0 == rhs.0 && lhs.1 == rhs.1
            }
            .map { passwords in
                passwords.0 == passwords.1
            }
            .eraseToAnyPublisher()
    }

    private var passwordsAreCorrectPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest3(passwordIsFilledPublisher, confirmPasswordIsFilledPublisher, passwordsMatchPublisher)
            .map { passwordIsFilled, confirmPasswordIsFilled, passwordsMatch in
                return passwordIsFilled && confirmPasswordIsFilled && passwordsMatch
            }
            .eraseToAnyPublisher()
    }

    private var formIsFilledPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest4(nameIsFilledPublisher, emailIsFilledPublisher, usernameIsFilledPublisher, passwordsAreCorrectPublisher)
            .map { nameIsFilled, emailIsFilled, usernameIsFilled, passwordsAreCorrect in
                return nameIsFilled && emailIsFilled && usernameIsFilled && passwordsAreCorrect
            }
            .eraseToAnyPublisher()
    }
}
