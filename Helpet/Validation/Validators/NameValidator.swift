//
//  NameValidator.swift
//  Helpet
//
//  Created by Efim Nikitin on 14.06.2023.
//

import Foundation

extension Validator where T == String {
    static func name() -> Self {
        Validator { data in
            return data.range(of: "^(?=.{1,64}$)([A-Za-zА-Яа-яЁё]+(\\s[A-Za-zА-Яа-яЁё]+)*)$", options: .regularExpression) != nil
        }
    }
}
