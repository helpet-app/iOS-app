//
//  SignUpRequest.swift
//  Helpet
//
//  Created by Efim Nikitin on 22.02.2023.
//

import Foundation

struct SignUpRequest: Request {
    typealias ReturnType = Tokens

    let path = "/auth/sign-up"

    let method: HTTPMethod = .post

    let body: [String: Any]?

    init(body: SignUpRequestBody) {
        self.body = body.asDictionary()
    }
}
