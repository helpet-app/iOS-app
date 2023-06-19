//
//  APIError.swift
//  Helpet
//
//  Created by Efim Nikitin on 10.02.2023.
//

import Foundation

struct APIError: Codable {
    var code: String

    var message: String
}
