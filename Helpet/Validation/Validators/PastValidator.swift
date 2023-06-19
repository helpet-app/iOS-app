//
//  PastValidator.swift
//  Helpet
//
//  Created by Efim Nikitin on 14.06.2023.
//

import Foundation

extension Validator where T == Date {
    static func past() -> Self {
        Validator { data in
            return Calendar.current.startOfDay(for: data) < Calendar.current.startOfDay(for: .now)
        }
    }
}

extension Validator where T == Date? {
    static func past() -> Self {
        Validator { data in
            if let data = data {
                return Validator<Date>.past().validate(data)
            }

            return true
        }
    }
}
