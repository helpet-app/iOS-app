//
//  URL+OptionalString.swift
//  Helpet
//
//  Created by Efim Nikitin on 07.05.2023.
//

import Foundation

extension URL {
    init?(string: String?) {
        guard let string = string else {
            return nil
        }

        self.init(string: string)
    }
}
