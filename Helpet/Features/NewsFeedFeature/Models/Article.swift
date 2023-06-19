//
//  Article.swift
//  Helpet
//
//  Created by Efim Nikitin on 18.01.2023.
//

import Foundation

struct Article: Identifiable, Codable {
    var id: UUID

    var articleCard: ArticleCard

    var content: String

    var sourceName: String?

    var sourceLink: String?
}
