//
//  GetProfileRequest.swift
//  Helpet
//
//  Created by Efim Nikitin on 02.05.2023.
//

import Foundation

struct GetProfileRequest: Request {
    typealias ReturnType = Profile

    let path = "/account"

    let authorized = true
}
