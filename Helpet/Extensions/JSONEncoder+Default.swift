//
//  JSONEncoder+Default.swift
//  Helpet
//
//  Created by Efim Nikitin on 08.05.2023.
//

import Foundation

extension JSONEncoder {
    static var `default`: JSONEncoder {
        let encoder = JSONEncoder()

        encoder.dateEncodingStrategy = .iso8601

        return encoder
    }
}
