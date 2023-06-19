//
//  Encodable+AsDictionary.swift
//  Helpet
//
//  Created by Efim Nikitin on 10.02.2023.
//

import Foundation

extension Encodable {
    func asDictionary(encoder: JSONEncoder = .default) -> [String: Any] {
        guard let data = try? encoder.encode(self) else { return [:] }

        guard let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else { return [:] }

        return dictionary
    }
}
