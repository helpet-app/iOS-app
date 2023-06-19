//
//  UsernameValidator.swift
//  Helpet
//
//  Created by Efim Nikitin on 03.03.2023.
//

import Foundation

extension Validator where T == String {
    static func username() -> Self {
        Validator { data in
            return data.range(of: "^(?!^\\..*)(?!.*\\.$)(?!.*\\.\\.)(?!^_+$)(?!^\\d+$)[A-Za-z0-9_.]{5,30}$", options: .regularExpression) != nil
        }
    }
}
