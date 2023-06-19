//
//  Tokens.swift
//  Helpet
//
//  Created by Efim Nikitin on 10.02.2023.
//

import Foundation

struct Tokens: Codable {
    var accessToken: String

    var accessExpiresIn: TimeInterval

    var refreshToken: String

    var refreshExpiresIn: TimeInterval

    var tokenType: String
}
