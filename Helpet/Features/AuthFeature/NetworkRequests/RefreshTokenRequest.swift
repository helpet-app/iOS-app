//
//  RefreshTokenRequest.swift
//  Helpet
//
//  Created by Efim Nikitin on 22.02.2023.
//

import Foundation

struct RefreshTokenRequest: Request {
    typealias ReturnType = Tokens

    let path = "/auth/token/refresh"

    let method: HTTPMethod = .post

    let body: [String: Any]?

    init(body: RefreshTokenRequestBody) {
        self.body = body.asDictionary()
    }
}
