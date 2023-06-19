//
//  GetVetRequest.swift
//  Helpet
//
//  Created by Efim Nikitin on 31.05.2023.
//

import Foundation

struct GetVetRequest: Request {
    typealias ReturnType = Vet

    let path: String

    let authorized = true

    init(vetId: UUID) {
        self.path = "/vets/\(vetId)"
    }
}
