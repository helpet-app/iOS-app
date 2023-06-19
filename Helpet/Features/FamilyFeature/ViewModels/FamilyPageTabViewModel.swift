//
//  FamilyPageTabViewModel.swift
//  Helpet
//
//  Created by Efim Nikitin on 24.01.2023.
//

import Foundation

final class FamilyPageTabViewModel: TabViewModel {
    enum TabType {
        case pets
        case familiesMembers
        case families
    }

    let tabs = [
        (label: Localizer.l10n(key: "FAMILY_PAGE.PETS_TAB_LABEL"), type: TabType.pets),
        (label: Localizer.l10n(key: "FAMILY_PAGE.FAMILIES_MEMBERS_TAB_LABEL"), type: TabType.familiesMembers),
        (label: Localizer.l10n(key: "FAMILY_PAGE.FAMILIES_TAB_LABEL"), type: TabType.families)
    ]

    @Published var selectedTab: TabType = .pets
}
