//
//  ListRowView.swift
//  Helpet
//
//  Created by Efim Nikitin on 25.01.2023.
//

import SwiftUI

struct ListRowView: View {
    let imageName: String

    let content: AnyView

    init<Content: View>(imageName: String, @ViewBuilder content: () -> Content) {
        self.imageName = imageName
        self.content = AnyView(content())
    }

    var body: some View {
        HStack(spacing: DefaultViewConstants.Spacing.medium) {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 28, height: 28)

            content
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .lineLimit(1)
    }
}

extension ListRowView {
    init(imageName: String, headline: String, subheadline: String? = nil) {
        self.imageName = imageName

        self.content = AnyView(
            VStack(alignment: .leading, spacing: DefaultViewConstants.Spacing.extraSmall) {
                Text(headline)
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(.Foreground.primary)

                if let subheadline = subheadline {
                    Text(subheadline)
                        .font(.footnote)
                        .foregroundColor(.Foreground.quinary)
                }
            }
        )
    }
}

struct ListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ListRowView(imageName: "globe", headline: "Hello, World", subheadline: "How are you doing today")
            .padding()
    }
}
