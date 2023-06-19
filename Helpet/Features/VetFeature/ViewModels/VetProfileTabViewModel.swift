//
//  VetProfileTabViewModel.swift
//  Helpet
//
//  Created by Efim Nikitin on 01.06.2023.
//

import Foundation

final class VetProfileTabViewModel: TabViewModel {
    enum TabType {
        case tariffs
        case contacts
        case schedule
    }

    let tabs = [
        (label: Localizer.l10n(key: "VET_PROFILE_PAGE.TARIFFS_TAB_LABEL"), type: TabType.tariffs),
        (label: Localizer.l10n(key: "VET_PROFILE_PAGE.CONTACTS_TAB_LABEL"), type: TabType.contacts),
        (label: Localizer.l10n(key: "VET_PROFILE_PAGE.SCHEDULE_TAB_LABEL"), type: TabType.schedule)
    ]

    @Published var selectedTab: TabType = .tariffs
}
