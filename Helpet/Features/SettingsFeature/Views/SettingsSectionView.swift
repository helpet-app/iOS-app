//
//  SettingsSectionView.swift
//  Helpet
//
//  Created by Efim Nikitin on 22.01.2023.
//

import SwiftUI

struct SettingsSectionView<Content: View>: View {
    @ViewBuilder let content: Content

    var body: some View {
        Subviews(of: content) { views in
            VStack(spacing: 0) {
                let lastId = views.last?.id

                ForEach(views) { view in
                    view

                    if view.id != lastId {
                        Divider()
                    }
                }
            }
        }
        .buttonStyle(NavigationLinkStyle())
        .background(Color.Background.secondary)
        .clipShape(RoundedRectangle(cornerRadius: DefaultViewConstants.CornerRadius.small, style: .continuous))
    }
}

struct SettingsSectionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            VStack {
                SettingsSectionView {
                    NavigationLink {

                    } label: {
                        SettingsRowView(label: "Notifications", imageName: "bell.fill")
                    }

                    NavigationLink {

                    } label: {
                        SettingsRowView(label: "Notifications", imageName: "bell.fill")
                    }

                    NavigationLink {

                    } label: {
                        SettingsRowView(label: "Notifications", imageName: "bell.fill")
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.Background.primary)
        }
    }
}
