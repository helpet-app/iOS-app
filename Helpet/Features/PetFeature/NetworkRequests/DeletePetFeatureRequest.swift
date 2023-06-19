//
//  DeletePetFeatureRequest.swift
//  Helpet
//
//  Created by Efim Nikitin on 14.06.2023.
//

import Foundation

struct DeletePetFeatureRequest: Request {
    typealias ReturnType = EmptyResponse

    let path: String

    let method: HTTPMethod = .delete

    let authorized = true

    init(petId: UUID, featureId: UUID) {
        self.path = "/user/pets/\(petId)/medical-card/features/\(featureId)"
    }
}
