//
//  CreatePetFeatureRequestBody.swift
//  Helpet
//
//  Created by Efim Nikitin on 10.06.2023.
//

import Foundation

struct CreatePetFeatureRequestBody: Codable {
    var name: String

    var description: String
}

extension CreatePetFeatureRequestBody: Validatable {
    enum ValidationError: ValidationErrorProtocol {
        case nameCannotBeBlank
        case descriptionCannotBeBlank

        var errorDescription: String? {
            switch self {
            case .nameCannotBeBlank: return Localizer.l10n(key: "VALIDATIONS.NAME_CANNOT_BE_BLANK_ERROR")
            case .descriptionCannotBeBlank: return Localizer.l10n(key: "VALIDATIONS.DESCRIPTION_CANNOT_BE_BLANK_ERROR")
            }
        }
    }

    func registerValidations() -> ValidationManager<CreatePetFeatureRequestBody> {
        ValidationManager
            .builder()
            .registerValidator(Validator.notBlank(), for: \.name, error: .nameCannotBeBlank)
            .registerValidator(Validator.notBlank(), for: \.description, error: .descriptionCannotBeBlank)
            .build()
    }
}
