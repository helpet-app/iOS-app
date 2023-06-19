//
//  Double+Formatted.swift
//  Helpet
//
//  Created by Efim Nikitin on 02.02.2023.
//

import Foundation

extension Double {
    func formatted(numberOfDigits: Int = 2) -> String {
        return String(format: "%.\(numberOfDigits)f", self)
    }
}
