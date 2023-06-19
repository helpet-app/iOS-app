//
//  CreatePetRequest.swift
//  Helpet
//
//  Created by Efim Nikitin on 07.06.2023.
//

import Foundation

struct CreatePetRequest: Request {
    typealias ReturnType = Pet

    let path = "/user/pets"

    let method: HTTPMethod = .post

    let body: [String: Any]?

    let authorized = true

    init(body: CreatePetRequestBody) {
        self.body = body.asDictionary()
    }
}
