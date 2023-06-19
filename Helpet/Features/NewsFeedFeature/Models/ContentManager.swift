//
//  ContentManager.swift
//  Helpet
//
//  Created by Efim Nikitin on 17.04.2023.
//

import Foundation

struct ContentManager: Identifiable, Codable {
    var id: UUID

    var name: String

    var avatarUrl: String?
}
