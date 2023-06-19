//
//  SettingsRowView.swift
//  Helpet
//
//  Created by Efim Nikitin on 21.01.2023.
//

import SwiftUI

struct SettingsRowView: View {
    let label: String

    let imageName: String

    var body: some View {
        HStack(spacing: DefaultViewConstants.Spacing.medium) {
            Image(systemName: imageName)
                .frame(width: 12, height: 12)
                .font(.system(size: 10))
                .padding(DefaultViewConstants.Padding.extraSmall)
                .foregroundColor(.Background.primary)
                .background(Color.Foreground.primary)
                .rounded(cornerRadius: DefaultViewConstants.CornerRadius.extraSmall)

            Text(label)
                .font(.callout)
                .lineLimit(1)
        }
        .modifier(NavigationLinkModifier())
        .padding(.vertical, DefaultViewConstants.Padding.small)
        .padding(.horizontal)
    }
}

struct SettingsRowView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsRowView(label: "Notifications", imageName: "bell.fill")
    }
}
