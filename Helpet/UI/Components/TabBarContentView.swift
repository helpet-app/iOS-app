//
//  TabBarContentView.swift
//  Helpet
//
//  Created by Efim Nikitin on 18.01.2023.
//

import SwiftUI

struct TabBarContentView<Content>: View where Content: View {
    let title: String

    let caption: String

    let icon: Image

    @ViewBuilder let content: Content

    var body: some View {
        NavigationStack {
            content
                .navigationTitle(title)
                .navigationBarTitleDisplayMode(.large)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.Background.primary)
        }
        .tabItem {
            Label {
                Text(caption)
            } icon: {
                icon
            }
        }
    }
}

struct TabBarItemView_Previews: PreviewProvider {
    static var previews: some View {
        TabView {
            TabBarContentView(title: "Home", caption: "Home", icon: Image(systemName: "house")) {
                Text("Home")
            }

            TabBarContentView(title: "Weather", caption: "Weather", icon: Image(systemName: "cloud.sun")) {
                Text("Weather")
            }

            TabBarContentView(title: "Settings", caption: "Settings", icon: Image(systemName: "gear")) {
                Text("Settings")
            }
        }
    }
}
