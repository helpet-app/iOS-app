//
//  SuccessfulResponseBody.swift
//  Helpet
//
//  Created by Efim Nikitin on 10.02.2023.
//

import Foundation

struct SuccessfulResponseBody<T: Codable>: Codable {
    var data: T
}
