//
//  PetMedicalCard.swift
//  Helpet
//
//  Created by Efim Nikitin on 05.06.2023.
//

import Foundation

struct PetMedicalCard: Identifiable, Codable {
    var id: UUID

    var name: String

    var avatarUrl: String?

    var petCategory: PetCategory?

    var species: Species?

    var gender: Gender?

    var dateOfBirth: Date?

    var isSpayedOrNeutered: Bool?

    var chipNumber: String?
}
