//
//  SignInRequestBody.swift
//  Helpet
//
//  Created by Efim Nikitin on 10.02.2023.
//

import Foundation

struct SignInRequestBody: Codable {
    var username: String

    var password: String
}

extension SignInRequestBody: Validatable {
    enum ValidationError: ValidationErrorProtocol {
        case usernameIsInvalid
        case passwordIsTooShort

        var errorDescription: String? {
            switch self {
            case .usernameIsInvalid: return Localizer.l10n(key: "VALIDATIONS.USERNAME_IS_INVALID_ERROR")
            case .passwordIsTooShort: return Localizer.l10n(key: "VALIDATIONS.PASSWORD_IS_TOO_SHORT_ERROR")
            }
        }
    }

    func registerValidations() -> ValidationManager<SignInRequestBody> {
        ValidationManager<SignInRequestBody>
            .builder()
            .registerValidator(Validator.username(), for: \.username, error: .usernameIsInvalid)
            .registerValidator(Validator.password(), for: \.password, error: .passwordIsTooShort)
            .build()
    }
}
