//
//  ForgotPasswordPageViewModel.swift
//  Helpet
//
//  Created by Efim Nikitin on 18.01.2023.
//

import Foundation
import Combine

final class ForgotPasswordPageViewModel: ObservableObject {
    @Published var forgotPasswordInfo = ForgotPasswordInfo()

    @Published private(set) var formIsFilled = false

    init() {
        formIsFilledPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: &$formIsFilled)
    }

    @MainActor
    func recoverPasswordButtonTapped() async {

    }
}

extension ForgotPasswordPageViewModel {
    private var formIsFilledPublisher: AnyPublisher<Bool, Never> {
        $forgotPasswordInfo
            .map(\.email)
            .removeDuplicates()
            .map { email in
                return !email.isEmpty
            }
            .eraseToAnyPublisher()
    }
}
