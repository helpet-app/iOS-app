//
//  ArticleContentPageView.swift
//  Helpet
//
//  Created by Efim Nikitin on 20.01.2023.
//

import SwiftUI

struct ArticleContentPageView: View {
    private let localizedConstants = LocalizedConstants()

    @StateObject private var viewModel: ArticleContentPageViewModel

    init(articleCard: ArticleCard) {
        self._viewModel = StateObject(wrappedValue: ArticleContentPageViewModel(articleId: articleCard.id))
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                if let article = viewModel.article {
                    ArticleContentView(article: article)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    DismissButtonView()
                }

                // if let article = viewModel.article {
                //     ToolbarItem(placement: .navigationBarTrailing) {
                //         Button {
                //
                //         } label: {
                //             Image(systemName: article.isSaved ? "bookmark.fill" : "bookmark")
                //                 .font(.body.weight(.bold))
                //         }
                //     }
                // }
            }
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.Background.primary)
            .fetchStatus(viewModel.requestStatus) {
                await viewModel.fetchArticle()
            }
        }
    }
}

extension ArticleContentPageView {
    private struct LocalizedConstants {
        let sourceLabel = Localizer.l10n(key: "ARTICLE_CONTENT_PAGE.SOURCE_LABEL")
    }
}

struct ArticleContentPageView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
