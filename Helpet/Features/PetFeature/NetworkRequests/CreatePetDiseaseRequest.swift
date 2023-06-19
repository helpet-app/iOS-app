//
//  CreatePetDiseaseRequest.swift
//  Helpet
//
//  Created by Efim Nikitin on 10.06.2023.
//

import Foundation

struct CreatePetDiseaseRequest: Request {
    typealias ReturnType = PetDisease

    let path: String

    let method: HTTPMethod = .post

    let body: [String: Any]?

    let authorized = true

    init(petId: UUID, body: CreatePetDiseaseRequestBody) {
        self.path = "/user/pets/\(petId)/medical-card/disease-history"
        self.body = body.asDictionary()
    }
}
