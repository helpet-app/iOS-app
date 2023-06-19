//
//  CreatePetDiseaseRequestBody.swift
//  Helpet
//
//  Created by Efim Nikitin on 10.06.2023.
//

import Foundation

struct CreatePetDiseaseRequestBody: Codable {
    var diseaseName: String

    var comment: String?

    var gotSickOn: Date

    var recoveredOn: Date?
}

extension CreatePetDiseaseRequestBody: Validatable {
    enum ValidationError: ValidationErrorProtocol {
        case nameCannotBeBlank
        case commentCannotBeBlank
        case gotSickOnCannotBeFuture
        case recoveredOnCannotBeFuture
        case gotSickOnCannotBeAfterRecoveredOn

        var errorDescription: String? {
            switch self {
            case .nameCannotBeBlank: return Localizer.l10n(key: "VALIDATIONS.NAME_CANNOT_BE_BLANK_ERROR")
            case .commentCannotBeBlank: return Localizer.l10n(key: "VALIDATIONS.COMMENT_CANNOT_BE_BLANK_ERROR")
            case .gotSickOnCannotBeFuture: return Localizer.l10n(key: "VALIDATIONS.GOT_SICK_ON_CANNOT_BE_FUTURE_ERROR")
            case .recoveredOnCannotBeFuture: return Localizer.l10n(key: "VALIDATIONS.RECOVERED_ON_CANNOT_BE_FUTURE_ERROR")
            case .gotSickOnCannotBeAfterRecoveredOn: return Localizer.l10n(key: "VALIDATIONS.GOT_SICK_ON_CANNOT_BE_AFTER_RECOVERED_ON_ERROR")
            }
        }
    }

    func registerValidations() -> ValidationManager<CreatePetDiseaseRequestBody> {
        ValidationManager
            .builder()
            .registerValidator(Validator.notBlank(), for: \.diseaseName, error: .nameCannotBeBlank)
            .registerValidator(Validator.notBlank(), for: \.comment, error: .commentCannotBeBlank)
            .registerValidator(Validator.pastOrPresent(), for: \.gotSickOn, error: .gotSickOnCannotBeFuture)
            .registerValidator(Validator.pastOrPresent(), for: \.recoveredOn, error: .recoveredOnCannotBeFuture)
            .registerValidator(error: .gotSickOnCannotBeAfterRecoveredOn) { model in
                if let recoveredOn = model.recoveredOn {
                    return model.gotSickOn <= recoveredOn
                }

                return true
            }
            .build()
    }
}
