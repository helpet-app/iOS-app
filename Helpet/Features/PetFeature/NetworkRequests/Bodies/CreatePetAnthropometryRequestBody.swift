//
//  CreatePetAnthropometryRequestBody.swift
//  Helpet
//
//  Created by Efim Nikitin on 10.06.2023.
//

import Foundation

struct CreatePetAnthropometryRequestBody: Codable {
    var height: Double

    var weight: Double

    var comment: String?
}

extension CreatePetAnthropometryRequestBody: Validatable {
    enum ValidationError: ValidationErrorProtocol {
        case commentCannotBeBlank

        var errorDescription: String? {
            switch self {
            case .commentCannotBeBlank: return Localizer.l10n(key: "VALIDATIONS.COMMENT_CANNOT_BE_BLANK_ERROR")
            }
        }
    }

    func registerValidations() -> ValidationManager<CreatePetAnthropometryRequestBody> {
        ValidationManager
            .builder()
            .registerValidator(Validator.notBlank(), for: \.comment, error: .commentCannotBeBlank)
            .build()
    }
}
