//
//  GetFamiliesRequest.swift
//  Helpet
//
//  Created by Efim Nikitin on 05.06.2023.
//

import Foundation

struct GetFamiliesRequest: Request {
    typealias ReturnType = [Family]

    let path = "/user/families"

    let authorized = true
}
