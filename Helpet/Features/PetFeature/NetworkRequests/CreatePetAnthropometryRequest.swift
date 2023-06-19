//
//  CreatePetAnthropometryRequest.swift
//  Helpet
//
//  Created by Efim Nikitin on 10.06.2023.
//

import Foundation

struct CreatePetAnthropometryRequest: Request {
    typealias ReturnType = PetAnthropometry

    let path: String

    let method: HTTPMethod = .post

    let body: [String: Any]?

    let authorized = true

    init(petId: UUID, body: CreatePetAnthropometryRequestBody) {
        self.path = "/user/pets/\(petId)/medical-card/anthropometry-history"
        self.body = body.asDictionary()
    }
}
