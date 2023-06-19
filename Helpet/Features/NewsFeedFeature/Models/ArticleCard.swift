//
//  ArticleCard.swift
//  Helpet
//
//  Created by Efim Nikitin on 17.04.2023.
//

import Foundation

struct ArticleCard: Identifiable, Codable {
    var id: UUID

    var title: String

    var description: String

    var imageUrl: String

    var createdAt: Date

    var createdBy: ContentManager

    var tags: [ArticleTag]
}
