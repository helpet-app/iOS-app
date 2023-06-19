//
//  GetPetsRequest.swift
//  Helpet
//
//  Created by Efim Nikitin on 05.06.2023.
//

import Foundation

struct GetPetsRequest: Request {
    typealias ReturnType = [Pet]

    let path = "/user/pets"

    let authorized = true
}
