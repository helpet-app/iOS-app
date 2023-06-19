//
//  GetVetScheduleRequest.swift
//  Helpet
//
//  Created by Efim Nikitin on 02.06.2023.
//

import Foundation

struct GetVetScheduleRequest: Request {
    typealias ReturnType = [VetScheduleSlot]

    let path: String

    let authorized = true

    init(vetId: UUID) {
        self.path = "/vets/\(vetId)/schedule"
    }
}
