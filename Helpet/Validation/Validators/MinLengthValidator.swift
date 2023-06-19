//
//  MinLengthValidator.swift
//  Helpet
//
//  Created by Efim Nikitin on 03.03.2023.
//

import Foundation

extension Validator where T == String {
    static func minLength(_ value: Int) -> Self {
        Validator { data in
            return data.count >= value
        }
    }
}
