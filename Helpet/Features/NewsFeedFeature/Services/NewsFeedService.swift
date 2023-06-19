//
//  NewsFeedService.swift
//  Helpet
//
//  Created by Efim Nikitin on 17.04.2023.
//

import Foundation

final class NewsFeedService {
    private let apiClient = APIClient(baseURL: APIConfig.Service.newsFeedServiceURL)

    func getArticle(id: UUID) async throws -> Article {
        return try await apiClient.dispatch(GetArticleRequest(articleId: id))
    }

    func getArticles(pageParams: PageParams, tags: [UUID] = []) async throws -> PageResponse<ArticleCard> {
        return try await apiClient.dispatch(GetArticleCardsRequest(pageParams: pageParams, tags: tags))
    }
}
