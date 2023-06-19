//
//  GetPetRequest.swift
//  Helpet
//
//  Created by Efim Nikitin on 05.06.2023.
//

import Foundation

struct GetPetRequest: Request {
    typealias ReturnType = Pet

    let path: String

    let authorized = true

    init(petId: UUID) {
        self.path = "/user/pets/\(petId)"
    }
}
