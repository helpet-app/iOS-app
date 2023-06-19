//
//  Token.swift
//  Helpet
//
//  Created by Efim Nikitin on 02.05.2023.
//

import Foundation

struct Token: Codable {
    var value: String

    var expiresAt: Date

    var type: String
}
