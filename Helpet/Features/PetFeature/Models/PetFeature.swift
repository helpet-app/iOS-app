//
//  PetFeature.swift
//  Helpet
//
//  Created by Efim Nikitin on 05.06.2023.
//

import Foundation

struct PetFeature: Identifiable, Codable {
    var id: UUID

    var name: String

    var description: String

    var createdAt: Date
}
