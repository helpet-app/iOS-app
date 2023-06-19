//
//  SignUpRequestBody.swift
//  Helpet
//
//  Created by Efim Nikitin on 22.02.2023.
//

import Foundation

struct SignUpRequestBody: Codable {
    var name: String

    var email: String

    var username: String

    var password: String
}

extension SignUpRequestBody: Validatable {
    enum ValidationError: ValidationErrorProtocol {
        case nameIsInvalid
        case emailIsInvalid
        case usernameIsInvalid
        case passwordIsInvalid

        var errorDescription: String? {
            switch self {
            case .nameIsInvalid: return Localizer.l10n(key: "VALIDATIONS.NAME_IS_INVALID_ERROR")
            case .emailIsInvalid: return Localizer.l10n(key: "VALIDATIONS.EMAIL_IS_INVALID_ERROR")
            case .usernameIsInvalid: return Localizer.l10n(key: "VALIDATIONS.USERNAME_IS_INVALID_ERROR")
            case .passwordIsInvalid: return Localizer.l10n(key: "VALIDATIONS.PASSWORD_IS_TOO_SHORT_ERROR")
            }
        }
    }

    func registerValidations() -> ValidationManager<SignUpRequestBody> {
        ValidationManager
            .builder()
            .registerValidator(Validator.name(), for: \.name, error: .nameIsInvalid)
            .registerValidator(Validator.email(), for: \.email, error: .emailIsInvalid)
            .registerValidator(Validator.username(), for: \.username, error: .usernameIsInvalid)
            .registerValidator(Validator.password(), for: \.password, error: .passwordIsInvalid)
            .build()
    }
}
