//
//  SignInRequest.swift
//  Helpet
//
//  Created by Efim Nikitin on 10.02.2023.
//

import Foundation

struct SignInRequest: Request {
    typealias ReturnType = Tokens

    let path = "/auth/sign-in"

    let method: HTTPMethod = .post

    let body: [String: Any]?

    init(body: SignInRequestBody) {
        self.body = body.asDictionary()
    }
}
