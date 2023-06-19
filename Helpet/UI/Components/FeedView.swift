//
//  FeedView.swift
//  Helpet
//
//  Created by Efim Nikitin on 09.02.2023.
//

import SwiftUI

struct FeedView<Item: Identifiable, ItemView: View>: View {
    let itemsGroupedByDate: [(key: Date, value: [Item])]

    @ViewBuilder let itemView: (Item) -> ItemView

    var body: some View {
        ScrollView {
            if itemsGroupedByDate.isEmpty {
                EmptyListView()
                    .padding(.top, UIScreen.mainBounds?.height * 0.3)
            } else {
                LazyVStack(spacing: DefaultViewConstants.Spacing.extraLarge) {
                    ForEach(itemsGroupedByDate, id: \.key) { date, items in
                        LazyVStack(alignment: .leading, spacing: DefaultViewConstants.Spacing.medium) {
                            Text(date.formatted(.dateTime.day().month(.wide)))
                                .font(.title3.weight(.bold))
                                .foregroundColor(.Foreground.primary)

                            ForEach(items) { item in
                                itemView(item)
                            }
                        }
                    }
                }
                .padding()
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        ArticlesFeedPageView()
    }
}
