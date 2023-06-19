//
//  CreatePetFeatureRequest.swift
//  Helpet
//
//  Created by Efim Nikitin on 10.06.2023.
//

import Foundation

struct CreatePetFeatureRequest: Request {
    typealias ReturnType = PetFeature

    let path: String

    let method: HTTPMethod = .post

    let body: [String: Any]?

    let authorized = true

    init(petId: UUID, body: CreatePetFeatureRequestBody) {
        self.path = "/user/pets/\(petId)/medical-card/features"
        self.body = body.asDictionary()
    }
}
