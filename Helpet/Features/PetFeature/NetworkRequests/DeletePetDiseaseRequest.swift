//
//  DeletePetDiseaseRequest.swift
//  Helpet
//
//  Created by Efim Nikitin on 14.06.2023.
//

import Foundation

struct DeletePetDiseaseRequest: Request {
    typealias ReturnType = EmptyResponse

    let path: String

    let method: HTTPMethod = .delete

    let authorized = true

    init(petId: UUID, diseaseId: UUID) {
        self.path = "/user/pets/\(petId)/medical-card/disease-history/\(diseaseId)"
    }
}
