//
//  Validatable.swift
//  Helpet
//
//  Created by Efim Nikitin on 03.03.2023.
//

import Foundation

protocol Validatable {
    associatedtype ValidationError: ValidationErrorProtocol

    func registerValidations() -> ValidationManager<Self>
}

extension Validatable {
    private func validationErrors() -> [ValidationError] {
        let validationManager = self.registerValidations()
        return validationManager.validate(self)
    }

    func validate() throws {
        guard let error = self.validationErrors().first else { return }
        throw error
    }
}
