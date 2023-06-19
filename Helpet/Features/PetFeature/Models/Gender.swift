//
//  Gender.swift
//  Helpet
//
//  Created by Efim Nikitin on 25.01.2023.
//

import Foundation

enum Gender: String, Codable {
    case boy = "BOY"
    case girl = "GIRL"

    var name: String {
        switch self {
        case .boy: return Localizer.l10n(key: "PET_PROFILE_PAGE.BOY_LABEL")
        case .girl: return Localizer.l10n(key: "PET_PROFILE_PAGE.GIRL_LABEL")
        }
    }
}
