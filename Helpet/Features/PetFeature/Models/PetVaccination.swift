//
//  PetVaccination.swift
//  Helpet
//
//  Created by Efim Nikitin on 05.06.2023.
//

import Foundation

struct PetVaccination: Identifiable, Codable {
    var id: UUID

    var vaccinationName: String

    var comment: String?

    var vaccinatedOn: Date

    var createdAt: Date
}
