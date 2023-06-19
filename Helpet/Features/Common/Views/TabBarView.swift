//
//  TabBarView.swift
//  Helpet
//
//  Created by Efim Nikitin on 18.01.2023.
//

import SwiftUI

struct TabBarView: View {
    @StateObject private var viewModel = TabBarViewModel()

    var body: some View {
        TabView(selection: $viewModel.selectedTab) {
            ForEach(viewModel.tabs, id: \.type) { tab in
                TabBarContentView(title: tab.title, caption: tab.caption, icon: Image(systemName: tab.imageName)) {
                    tabContentView(for: tab.type)
                }
                .tag(tab.type)
            }
        }
    }
}

extension TabBarView {
    @ViewBuilder
    func tabContentView(for tabBarItemType: TabBarViewModel.TabBarItemType) -> some View {
        switch tabBarItemType {
        case .articlesFeedPage:
            ArticlesFeedPageView()
        case .vetsFeedPage:
            VetsFeedPageView()
        case .appointmentsPage:
            AppointmentsFeedPageView()
        case .familyPage:
            FamilyPageView()
        case .profilePage:
            UserProfilePageView()
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
