//
//  UpdateProfileRequest.swift
//  Helpet
//
//  Created by Efim Nikitin on 17.04.2023.
//

import Foundation

struct UpdateProfileRequest: Request {
    typealias ReturnType = Profile

    let path = "/account"

    let method: HTTPMethod = .patch

    let body: [String: Any]?

    let authorized = true

    init(body: UpdateProfileRequestBody) {
        self.body = body.asDictionary()
    }
}
