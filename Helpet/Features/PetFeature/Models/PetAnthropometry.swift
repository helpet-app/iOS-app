//
//  PetAnthropometry.swift
//  Helpet
//
//  Created by Efim Nikitin on 05.06.2023.
//

import Foundation

struct PetAnthropometry: Identifiable, Codable {
    var id: UUID

    var height: Double

    var weight: Double

    var comment: String?

    var createdAt: Date
}
