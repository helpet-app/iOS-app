//
//  FeedCardView.swift
//  Helpet
//
//  Created by Efim Nikitin on 09.02.2023.
//

import SwiftUI

struct FeedCardView: View {
    let imageUrl: String?

    let tags: [String]

    let headline: String

    let subheadline: String?

    init(imageUrl: String? = nil, tags: [String], headline: String, subheadline: String? = nil) {
        self.imageUrl = imageUrl
        self.tags = tags
        self.headline = headline
        self.subheadline = subheadline
    }

    var image: some View {
        CachedImage(url: URL(string: imageUrl))
            .frame(maxWidth: .infinity, minHeight: 300, maxHeight: 300)
            .clipped()
    }

    var tagsView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(tags, id: \.self) { tag in
                    TagView(caption: tag)
                }
            }
        }
    }

    var headlineView: some View {
        Text(headline)
            .font(.headline)
            .fontWeight(.bold)
            .lineLimit(3)
            .foregroundColor(.Foreground.primary)
    }

    @ViewBuilder
    var subheadlineView: some View {
        if let subheadline = subheadline {
            Text(subheadline)
                .font(.subheadline)
                .fontWeight(.semibold)
                .lineLimit(2)
                .foregroundColor(.Foreground.quinary)
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            image

            Divider()

            VStack(alignment: .leading, spacing: DefaultViewConstants.Spacing.small) {
                tagsView

                VStack(alignment: .leading, spacing: DefaultViewConstants.Spacing.extraSmall) {
                    headlineView

                    subheadlineView
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
        .background(Color.Background.secondary)
        .rounded()
    }
}

struct FeedCardView_Previews: PreviewProvider {
    static var previews: some View {
        FeedCardView(imageUrl: "https://www.mos.ru/upload/newsfeed/newsfeed/vakc(918).jpg",
                     tags: ["Health", "Vaccines", "Vaccination"],
                     headline: "Vaccinations for Your Pet",
                     subheadline: "Why vaccination is safe and important")
    }
}
