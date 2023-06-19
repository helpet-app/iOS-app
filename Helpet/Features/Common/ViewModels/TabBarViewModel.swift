//
//  TabBarViewModel.swift
//  Helpet
//
//  Created by Efim Nikitin on 18.01.2023.
//

import Foundation

final class TabBarViewModel: ObservableObject {
    let tabs = [
        TabBarItem(title: Localizer.l10n(key: "ARTICLES_FEED_PAGE.TITLE"),
                   caption: Localizer.l10n(key: "ARTICLES_FEED_PAGE.TAB_CAPTION"),
                   imageName: "note.text",
                   type: .articlesFeedPage),
        TabBarItem(title: Localizer.l10n(key: "VETS_FEED_PAGE.TITLE"),
                   caption: Localizer.l10n(key: "VETS_FEED_PAGE.TAB_CAPTION"),
                   imageName: "heart.text.square",
                   type: .vetsFeedPage),
        TabBarItem(title: Localizer.l10n(key: "APPOINTMENTS_PAGE.TITLE"),
                   caption: Localizer.l10n(key: "APPOINTMENTS_PAGE.TAB_CAPTION"),
                   imageName: "calendar",
                   type: .appointmentsPage),
        TabBarItem(title: Localizer.l10n(key: "FAMILY_PAGE.TITLE"),
                   caption: Localizer.l10n(key: "FAMILY_PAGE.TAB_CAPTION"),
                   imageName: "person.2",
                   type: .familyPage),
        TabBarItem(title: Localizer.l10n(key: "USER_PROFILE_PAGE.TITLE"),
                   caption: Localizer.l10n(key: "USER_PROFILE_PAGE.TAB_CAPTION"),
                   imageName: "person.crop.circle.fill",
                   type: .profilePage)
    ]

    @Published var selectedTab: TabBarItemType = .articlesFeedPage
}

extension TabBarViewModel {
    enum TabBarItemType {
        case articlesFeedPage
        case vetsFeedPage
        case appointmentsPage
        case familyPage
        case profilePage
    }

    struct TabBarItem {
        var title: String

        var caption: String

        var imageName: String

        var type: TabBarItemType
    }
}
