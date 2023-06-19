//
//  PasswordValidator.swift
//  Helpet
//
//  Created by Efim Nikitin on 02.05.2023.
//

import Foundation

extension Validator where T == String {
    static func password() -> Self {
        return minLength(8)
    }
}
