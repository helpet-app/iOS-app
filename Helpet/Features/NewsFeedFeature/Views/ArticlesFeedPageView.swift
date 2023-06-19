//
//  ArticlesFeedPageView.swift
//  Helpet
//
//  Created by Efim Nikitin on 18.01.2023.
//

import SwiftUI

struct ArticlesFeedPageView: View {
    @StateObject private var viewModel = ArticlesFeedPageViewModel()

    @State private var selectedArticle: ArticleCard?

    var body: some View {
        VStack {
            FeedView(itemsGroupedByDate: viewModel.articleCardsGroupedByDate) { articleCard in
                Button {
                    selectedArticle = articleCard
                } label: {
                    FeedCardView(imageUrl: articleCard.imageUrl,
                                 tags: articleCard.tags.map(\.name),
                                 headline: articleCard.title,
                                 subheadline: articleCard.description)
                }
                .sheet(item: $selectedArticle) { article in
                    ArticleContentPageView(articleCard: article)
                }
                .buttonStyle(ScaledButtonStyle())
            }
            .refreshable {
                await viewModel.fetchArticles()
            }
            .fetchStatus(viewModel.requestStatus) {
                await viewModel.fetchArticles()
            }
        }
        .background(Color.Background.primary)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {

                } label: {
                    Image(systemName: "bookmark.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                }
            }

            ToolbarItem(placement: .navigationBarTrailing) {
                Button {

                } label: {
                    Image(systemName: "line.3.horizontal.decrease.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                }
            }
        }
        .animation(.default, value: viewModel.articleCardsGroupedByDate.isEmpty)
    }
}

struct ArticlesFeedPageView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
