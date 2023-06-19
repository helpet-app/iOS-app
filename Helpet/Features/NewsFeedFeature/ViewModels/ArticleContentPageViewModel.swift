//
//  ArticleContentPageViewModel.swift
//  Helpet
//
//  Created by Efim Nikitin on 20.01.2023.
//

import Foundation

final class ArticleContentPageViewModel: ObservableObject {
    private let newsFeedService = NewsFeedService()

    private let articleId: UUID

    @Published private(set) var article: Article?

    @Published private(set) var requestStatus: RequestStatus?

    init(articleId: UUID) {
        self.articleId = articleId

        Task {
            await fetchArticle()
        }
    }

    @MainActor
    func fetchArticle() async {
        self.requestStatus = .loading

        do {
            self.article = try await newsFeedService.getArticle(id: articleId)
            self.requestStatus = .success
        } catch {
            self.requestStatus = .failure(error: error)
        }
    }
}
