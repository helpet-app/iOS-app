//
//  Pet.swift
//  Helpet
//
//  Created by Efim Nikitin on 05.06.2023.
//

import Foundation

struct Pet: Identifiable, Codable {
    var id: UUID

    var name: String

    var avatarUrl: String?

    var petCategory: PetCategory?

    var species: Species?

    var family: Family?

    struct Family: Identifiable, Hashable, Codable {
        var id: UUID

        var name: String
    }
}

extension Pet: Hashable {
    static func == (lhs: Pet, rhs: Pet) -> Bool {
        return lhs.id == rhs.id
    }
}
