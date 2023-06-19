//
//  CreatePetVaccinationRequestBody.swift
//  Helpet
//
//  Created by Efim Nikitin on 10.06.2023.
//

import Foundation

struct CreatePetVaccinationRequestBody: Codable {
    var vaccinationName: String

    var comment: String?

    var vaccinatedOn: Date
}

extension CreatePetVaccinationRequestBody: Validatable {
    enum ValidationError: ValidationErrorProtocol {
        case nameCannotBeBlank
        case commentCannotBeBlank
        case vaccinatedOnCannotBeFuture

        var errorDescription: String? {
            switch self {
            case .nameCannotBeBlank: return Localizer.l10n(key: "VALIDATIONS.NAME_CANNOT_BE_BLANK_ERROR")
            case .commentCannotBeBlank: return Localizer.l10n(key: "VALIDATIONS.COMMENT_CANNOT_BE_BLANK_ERROR")
            case .vaccinatedOnCannotBeFuture: return Localizer.l10n(key: "VALIDATIONS.VACCINATED_ON_CANNOT_BE_FUTURE_ERROR")
            }
        }
    }

    func registerValidations() -> ValidationManager<CreatePetVaccinationRequestBody> {
        ValidationManager
            .builder()
            .registerValidator(Validator.notBlank(), for: \.vaccinationName, error: .nameCannotBeBlank)
            .registerValidator(Validator.notBlank(), for: \.comment, error: .commentCannotBeBlank)
            .registerValidator(Validator.pastOrPresent(), for: \.vaccinatedOn, error: .vaccinatedOnCannotBeFuture)
            .build()
    }
}
