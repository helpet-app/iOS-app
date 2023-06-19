//
//  ArticleContentView.swift
//  Helpet
//
//  Created by Efim Nikitin on 20.01.2023.
//

import SwiftUI

struct ArticleContentView: View {
    private let localizedConstants = LocalizedConstants()

    let article: Article

    var header: some View {
        Text("\(article.articleCard.createdBy.name) • \(article.articleCard.createdAt.formatted(.dateTime.day().month(.wide).hour().minute()))")
            .font(.footnote)
            .fontWeight(.medium)
            .foregroundColor(.Foreground.quaternary)
    }

    var title: some View {
        Text(article.articleCard.title)
            .font(.title2)
            .fontWeight(.bold)
    }

    var description: some View {
        Text(article.articleCard.description)
            .font(.headline.weight(.semibold))
            .fontWeight(.semibold)
            .foregroundColor(.Foreground.quinary)
    }

    var image: some View {
        CachedImage(url: URL(string: article.articleCard.imageUrl))
            .frame(maxWidth: .infinity, minHeight: 300, maxHeight: 300)
            .padding(.vertical)
    }

    var content: some View {
        Text(article.content)
            .foregroundColor(.Foreground.quaternary)
            .lineSpacing(DefaultViewConstants.Spacing.small)
            .font(.system(.body, design: .rounded).weight(.medium))
            .padding(.bottom)
    }

    var source: some View {
        Group {
            if let sourceName = article.sourceName, let sourceLink = article.sourceLink {
                HStack {
                    Text("\(localizedConstants.sourceLabel):")
                        .foregroundColor(.Foreground.quinary)

                    Link(destination: URL(string: sourceLink)!) {
                        Text("\(sourceName)")
                            .underline()
                            .foregroundColor(.blue)
                    }
                }
                .font(.footnote)
            } else {
                EmptyView()
            }
        }
        .padding(.bottom)
    }

    var tags: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(article.articleCard.tags) { tag in
                    TagView(caption: tag.name)
                }
            }
        }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: DefaultViewConstants.Spacing.small) {
                header

                title

                description

                image

                content

                source

                tags
            }
            .foregroundColor(.Foreground.primary)
            .padding()
        }
    }
}

extension ArticleContentView {
    private struct LocalizedConstants {
        let sourceLabel = Localizer.l10n(key: "ARTICLE_CONTENT_PAGE.SOURCE_LABEL")
    }
}

struct ArticleContentView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
