//
//  Localizer.swift
//  Helpet
//
//  Created by Efim Nikitin on 16.01.2023.
//

import Foundation

struct Localizer {
    private init() {}

    static func l10n(key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
}
