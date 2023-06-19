//
//  GetPetAppointmentsRequest.swift
//  Helpet
//
//  Created by Efim Nikitin on 05.06.2023.
//

import Foundation

struct GetPetAppointmentsRequest: Request {
    typealias ReturnType = PageResponse<Appointment>

    let path: String

    let queryParams: [String: Any]?

    let authorized = true

    init(petId: UUID, pageParams: PageParams) {
        self.path = "/user/pets/\(petId)/appointments"
        self.queryParams = pageParams.asDictionary()
    }
}
