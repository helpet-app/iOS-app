//
//  GetArticleRequest.swift
//  Helpet
//
//  Created by Efim Nikitin on 17.04.2023.
//

import Foundation

struct GetArticleRequest: Request {
    typealias ReturnType = Article

    let path: String

    let authorized = true

    init(articleId: UUID) {
        self.path = "/articles/\(articleId)"
    }
}
