//
//  GetPetVaccinationHistoryRequest.swift
//  Helpet
//
//  Created by Efim Nikitin on 05.06.2023.
//

import Foundation

struct GetPetVaccinationHistoryRequest: Request {
    typealias ReturnType = PageResponse<PetVaccination>

    let path: String

    let queryParams: [String: Any]?

    let authorized = true

    init(petId: UUID, pageParams: PageParams) {
        self.path = "/user/pets/\(petId)/medical-card/vaccination-history"
        self.queryParams = pageParams.asDictionary()
    }
}
