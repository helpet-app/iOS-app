//
//  PageParams.swift
//  Helpet
//
//  Created by Efim Nikitin on 17.04.2023.
//

import Foundation

struct PageParams: Codable {
    var page: Int = 0

    var size: Int = 10

    mutating func goToNextPage() {
        self.page += 1
    }
}
