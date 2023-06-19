//
//  NotificationBannerView.swift
//  Helpet
//
//  Created by Efim Nikitin on 15.06.2023.
//

import SwiftUI

struct NotificationBannerView: View {
    let title: String

    let message: String?

    init(title: String, message: String? = nil) {
        self.title = title
        self.message = message
    }

    var body: some View {
        HStack(spacing: DefaultViewConstants.Spacing.medium) {
            Image(systemName: "exclamationmark.circle.fill")

            VStack(alignment: .leading, spacing: DefaultViewConstants.Spacing.extraSmall) {
                Text(title)
                    .fontWeight(.medium)

                if let message = message {
                    Text(message)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.footnote)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .foregroundColor(.Foreground.primary)
        .background(Color.Background.tertiary)
        .rounded()
        .padding(.horizontal, 8)
    }
}

struct NotificationBannerView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationBannerView(title: "Неполадки с соединением", message: "Проверьте доступ к интернету")
    }
}
