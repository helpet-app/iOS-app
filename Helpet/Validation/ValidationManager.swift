//
//  ValidationManager.swift
//  Helpet
//
//  Created by Efim Nikitin on 03.03.2023.
//

import Foundation

struct ValidationManager<Model> where Model: Validatable {
    private var validators: [(validator: Validator<Model>, error: Model.ValidationError)] = []

    mutating func registerValidator<T>(_ validator: Validator<T>, for keyPath: KeyPath<Model, T>, error: Model.ValidationError) {
        self.registerValidator(for: keyPath, error: error) { data in
            return validator.validate(data)
        }
    }

    mutating func registerValidator<T>(for keyPath: KeyPath<Model, T>, error: Model.ValidationError, validator: @escaping (T) -> Bool) {
        self.registerValidator(error: error) { model in
            return validator(model[keyPath: keyPath])
        }
    }

    mutating func registerValidator(error: Model.ValidationError, validator: @escaping (Model) -> Bool) {
        self.validators.append((validator: Validator<Model> { model in
            return validator(model)
        }, error: error))
    }

    func validate(_ model: Model) -> [Model.ValidationError] {
        return self.validators.compactMap { validator, error in
            return validator.validate(model) ? nil : error
        }
    }
}

extension ValidationManager {
    static func builder() -> ValidationManagerBuilder {
        return ValidationManagerBuilder()
    }

    class ValidationManagerBuilder {
        private var validationManager = ValidationManager<Model>()

        func registerValidator<T>(_ validator: Validator<T>, for keyPath: KeyPath<Model, T>, error: Model.ValidationError) -> ValidationManagerBuilder {
            self.validationManager.registerValidator(validator, for: keyPath, error: error)

            return self
        }

        func registerValidator<T>(for keyPath: KeyPath<Model, T>, error: Model.ValidationError, validator: @escaping (T) -> Bool) -> ValidationManagerBuilder {
            self.validationManager.registerValidator(for: keyPath, error: error, validator: validator)

            return self
        }

        func registerValidator(error: Model.ValidationError, validator: @escaping (Model) -> Bool) -> ValidationManagerBuilder {
            self.validationManager.registerValidator(error: error, validator: validator)

            return self
        }

        func build() -> ValidationManager<Model> {
            return validationManager
        }
    }
}
