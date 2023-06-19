//
//  GetArticleCardsRequest.swift
//  Helpet
//
//  Created by Efim Nikitin on 17.04.2023.
//

import Foundation

struct GetArticleCardsRequest: Request {
    typealias ReturnType = PageResponse<ArticleCard>

    let path = "/articles"

    let queryParams: [String: Any]?

    let authorized = true

    init(pageParams: PageParams, tags: [UUID] = []) {
        var queryParams = pageParams.asDictionary()
        queryParams["tag-id"] = tags
        self.queryParams = queryParams
    }
}
