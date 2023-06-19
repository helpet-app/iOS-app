//
//  WordValidator.swift
//  Helpet
//
//  Created by Efim Nikitin on 14.06.2023.
//

import Foundation

extension Validator where T == String {
    static func word() -> Self {
        Validator { data in
            return data.range(of: "^(?=.{1,30}$)([A-Za-zА-Яа-яЁё\\d]+)$", options: .regularExpression) != nil
        }
    }
}
