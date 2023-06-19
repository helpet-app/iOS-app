//
//  Profile.swift
//  Helpet
//
//  Created by Efim Nikitin on 22.02.2023.
//

import Foundation

struct Profile: Identifiable, Codable {
    var id: UUID

    var username: String

    var name: String

    var email: String

    var isEmailVerified: Bool

    var isEnabled: Bool

    var isBlocked: Bool
}
