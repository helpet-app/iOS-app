//
//  NotBlankValidator.swift
//  Helpet
//
//  Created by Efim Nikitin on 14.06.2023.
//

import Foundation

extension Validator where T == String {
    static func notBlank() -> Self {
        Validator { data in
            return !data.isBlank()
        }
    }
}

extension Validator where T == String? {
    static func notBlank() -> Self {
        Validator { data in
            if let data = data {
                return Validator<String>.notBlank().validate(data)
            }

            return true
        }
    }
}
