//
//  CreatePetRequestBody.swift
//  Helpet
//
//  Created by Efim Nikitin on 07.06.2023.
//

import Foundation

struct CreatePetRequestBody: Codable {
    var name: String

    var petCategoryId: Int
}

extension CreatePetRequestBody: Validatable {
    enum ValidationError: ValidationErrorProtocol {
        case nameCannotBeBlank

        var errorDescription: String? {
            switch self {
            case .nameCannotBeBlank: return Localizer.l10n(key: "VALIDATIONS.NAME_CANNOT_BE_BLANK_ERROR")
            }
        }
    }

    func registerValidations() -> ValidationManager<CreatePetRequestBody> {
        ValidationManager
            .builder()
            .registerValidator(Validator.notBlank(), for: \.name, error: .nameCannotBeBlank)
            .build()
    }
}
