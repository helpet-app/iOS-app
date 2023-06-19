//
//  UnsuccessfulResponseBody.swift
//  Helpet
//
//  Created by Efim Nikitin on 10.02.2023.
//

import Foundation

struct UnsuccessfulResponseBody: Codable {
    var errors: [APIError]
}
