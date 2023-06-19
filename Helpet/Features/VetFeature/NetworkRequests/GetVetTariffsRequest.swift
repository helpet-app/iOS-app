//
//  GetVetTariffsRequest.swift
//  Helpet
//
//  Created by Efim Nikitin on 31.05.2023.
//

import Foundation

struct GetVetTariffsRequest: Request {
    typealias ReturnType = [VetTariff]

    let path: String

    let authorized = true

    init(vetId: UUID) {
        self.path = "/vets/\(vetId)/tariffs"
    }
}
