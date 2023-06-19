//
//  PetDisease.swift
//  Helpet
//
//  Created by Efim Nikitin on 05.06.2023.
//

import Foundation

struct PetDisease: Identifiable, Codable {
    var id: UUID

    var diseaseName: String

    var comment: String?

    var gotSickOn: Date

    var recoveredOn: Date?

    var createdAt: Date
}
