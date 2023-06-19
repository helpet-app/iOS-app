//
//  GetCategorySpeciesRequest.swift
//  Helpet
//
//  Created by Efim Nikitin on 07.06.2023.
//

import Foundation

struct GetCategorySpeciesRequest: Request {
    typealias ReturnType = PageResponse<Species>

    let path: String

    let queryParams: [String: Any]?

    let authorized = true

    init(categoryId: Int, searchName: String? = nil, pageParams: PageParams) {
        self.path = "/pet-categories/\(categoryId)/species"
        var queryParams = pageParams.asDictionary()
        queryParams["name"] = searchName
        self.queryParams = queryParams
    }
}
