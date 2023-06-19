//
//  UpdateProfileRequestBody.swift
//  Helpet
//
//  Created by Efim Nikitin on 17.04.2023.
//

import Foundation

struct UpdateProfileRequestBody: Codable {
    var name: String

    var username: String
}

extension UpdateProfileRequestBody: Validatable {
    enum ValidationError: ValidationErrorProtocol {
        case nameIsInvalid
        case usernameIsInvalid

        var errorDescription: String? {
            switch self {
            case .nameIsInvalid: return Localizer.l10n(key: "VALIDATIONS.NAME_IS_INVALID_ERROR")
            case .usernameIsInvalid: return Localizer.l10n(key: "VALIDATIONS.USERNAME_IS_INVALID_ERROR")
            }
        }
    }

    func registerValidations() -> ValidationManager<UpdateProfileRequestBody> {
        ValidationManager
            .builder()
            .registerValidator(Validator.name(), for: \.name, error: .nameIsInvalid)
            .registerValidator(Validator.username(), for: \.username, error: .usernameIsInvalid)
            .build()
    }
}
