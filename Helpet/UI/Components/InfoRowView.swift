//
//  InfoRowView.swift
//  Helpet
//
//  Created by Efim Nikitin on 16.06.2023.
//

import SwiftUI

struct InfoRowView: View {
    let label: String

    let content: AnyView

    init<Content: View>(label: String, @ViewBuilder content: () -> Content) {
        self.label = label
        self.content = AnyView(content())
    }

    var body: some View {
        content
            .font(.system(.subheadline, design: .rounded).weight(.regular))
            .lineSpacing(DefaultViewConstants.Spacing.small)
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.Background.secondary)
            .rounded()
            .label(label)
    }
}

extension InfoRowView {
    init(label: String, content: String? = nil) {
        self.label = label

        self.content = AnyView(
            Text(content ?? Localizer.l10n(key: "INFO_ROW_COMPONENT.NO_INFORMATION_LABEL"))
                .foregroundColor(content == nil ? .Foreground.quinary : .Foreground.primary)
        )
    }
}
