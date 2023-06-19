//
//  PageResponse.swift
//  Helpet
//
//  Created by Efim Nikitin on 17.04.2023.
//

import Foundation

struct PageResponse<T: Codable>: Codable {
    var totalNumberOfPages: Int

    var totalNumberOfElements: Int

    var size: Int

    var number: Int

    var numberOfElements: Int

    var content: [T]
}
