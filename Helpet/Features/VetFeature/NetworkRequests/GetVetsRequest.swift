//
//  GetVetsRequest.swift
//  Helpet
//
//  Created by Efim Nikitin on 31.05.2023.
//

import Foundation

struct GetVetsRequest: Request {
    typealias ReturnType = PageResponse<Vet>

    let path = "/vets"

    let queryParams: [String: Any]?

    let authorized = true

    init(pageParams: PageParams, tags: [UUID] = []) {
        var queryParams = pageParams.asDictionary()
        queryParams["tag-id"] = tags
        self.queryParams = queryParams
    }
}
