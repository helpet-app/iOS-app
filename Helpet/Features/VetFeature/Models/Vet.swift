//
//  Vet.swift
//  Helpet
//
//  Created by Efim Nikitin on 02.02.2023.
//

import Foundation

struct Vet: Identifiable, Codable {
    var id: UUID

    var name: String

    var bio: String?

    var avatarUrl: String?

    var available: Bool

    var tags: [VetTag]
}
