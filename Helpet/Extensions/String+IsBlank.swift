//
//  String+IsBlank.swift
//  Helpet
//
//  Created by Efim Nikitin on 14.06.2023.
//

import Foundation

extension String {
    func isBlank() -> Bool {
        for character in self {
            if !character.isWhitespace {
                return false
            }
        }

        return true
    }
}
