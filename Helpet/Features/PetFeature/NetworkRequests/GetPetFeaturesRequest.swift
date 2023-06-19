//
//  GetPetFeaturesRequest.swift
//  Helpet
//
//  Created by Efim Nikitin on 05.06.2023.
//

import Foundation

struct GetPetFeaturesRequest: Request {
    typealias ReturnType = [PetFeature]

    let path: String

    let authorized = true

    init(petId: UUID) {
        self.path = "/user/pets/\(petId)/medical-card/features"
    }
}
