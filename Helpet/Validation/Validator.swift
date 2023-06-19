//
//  Validator.swift
//  Helpet
//
//  Created by Efim Nikitin on 03.03.2023.
//

import Foundation

struct Validator<T> {
    let validate: (T) -> Bool

    init(validate: @escaping (T) -> Bool) {
        self.validate = validate
    }
}
