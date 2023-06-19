//
//  SignOutRequest.swift
//  Helpet
//
//  Created by Efim Nikitin on 22.02.2023.
//

import Foundation

struct SignOutRequest: Request {
    typealias ReturnType = EmptyResponse

    let path = "/auth/sign-out"

    let method: HTTPMethod = .post

    let authorized = true
}
