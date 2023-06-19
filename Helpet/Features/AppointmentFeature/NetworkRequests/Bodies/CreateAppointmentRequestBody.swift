//
//  CreateAppointmentRequestBody.swift
//  Helpet
//
//  Created by Efim Nikitin on 18.06.2023.
//

import Foundation

struct CreateAppointmentRequestBody: Codable {
    var problem: String

    var vetId: UUID

    var petId: UUID

    var date: Date

    var timeSlotId: Int
}

extension CreateAppointmentRequestBody: Validatable {
    enum ValidationError: ValidationErrorProtocol {
        case problemCannotBeBlank
        case dateCannotBePastOrPresent

        var errorDescription: String? {
            switch self {
            case .problemCannotBeBlank: return Localizer.l10n(key: "VALIDATIONS.PROBLEM_CANNOT_BE_BLANK_ERROR")
            case .dateCannotBePastOrPresent: return Localizer.l10n(key: "VALIDATIONS.DATE_CANNOT_BE_PAST_OR_PRESENT")
            }
        }
    }

    func registerValidations() -> ValidationManager<CreateAppointmentRequestBody> {
        ValidationManager
            .builder()
            .registerValidator(Validator.notBlank(), for: \.problem, error: .problemCannotBeBlank)
            .registerValidator(Validator.future(), for: \.date, error: .dateCannotBePastOrPresent)
            .build()
    }
}
