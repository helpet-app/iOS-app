//
//  EmailValidator.swift
//  Helpet
//
//  Created by Efim Nikitin on 14.06.2023.
//

import Foundation

extension Validator where T == String {
    static func email() -> Self {
        Validator { data in
            return data.range(of: "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$", options: .regularExpression) != nil
        }
    }
}
