//
//  CreatePetVaccinationRequest.swift
//  Helpet
//
//  Created by Efim Nikitin on 10.06.2023.
//

import Foundation

struct CreatePetVaccinationRequest: Request {
    typealias ReturnType = PetVaccination

    let path: String

    let method: HTTPMethod = .post

    let body: [String: Any]?

    let authorized = true

    init(petId: UUID, body: CreatePetVaccinationRequestBody) {
        self.path = "/user/pets/\(petId)/medical-card/vaccination-history"
        self.body = body.asDictionary()
    }
}
