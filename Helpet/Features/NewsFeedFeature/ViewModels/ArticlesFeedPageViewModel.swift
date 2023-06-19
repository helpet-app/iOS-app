//
//  ArticlesFeedPageViewModel.swift
//  Helpet
//
//  Created by Efim Nikitin on 18.01.2023.
//

import Foundation

final class ArticlesFeedPageViewModel: ObservableObject {
    private let newsFeedService = NewsFeedService()

    private var pageParams = PageParams()

    @Published private(set) var articleCardsGroupedByDate: [(key: Date, value: [ArticleCard])] = []

    @Published private(set) var requestStatus: RequestStatus?

    init() {
        self.requestStatus = .loading

        Task {
            await fetchArticles()
        }
    }

    @MainActor
    func fetchArticles() async {
        do {
            let articleCards = try await newsFeedService.getArticles(pageParams: pageParams).content

            self.articleCardsGroupedByDate = articleCards.groupedBy(dateComponents: [.day, .month, .year], key: \.createdAt).sorted { $0.key > $1.key }

            self.requestStatus = .success
        } catch {
            self.requestStatus = .failure(error: error)
        }
    }
}
