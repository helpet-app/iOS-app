//
//  PetProfileTabViewModel.swift
//  Helpet
//
//  Created by Efim Nikitin on 01.02.2023.
//

import Foundation

final class PetProfileTabViewModel: TabViewModel {
    enum TabType {
        case appointmentHistory
        case petFeatures
        case diseaseHistory
        case antropometryHistory
        case vaccinationHistory
    }

    let tabs = [
        (label: Localizer.l10n(key: "PET_PROFILE_PAGE.APPOINTMENTS_TAB_LABEL"), type: TabType.appointmentHistory),
        (label: Localizer.l10n(key: "PET_PROFILE_PAGE.PET_FEATURES_TAB_LABEL"), type: TabType.petFeatures),
        (label: Localizer.l10n(key: "PET_PROFILE_PAGE.DISEASES_TAB_LABEL"), type: TabType.diseaseHistory),
        (label: Localizer.l10n(key: "PET_PROFILE_PAGE.ANTHROPOMETRY_TAB_LABEL"), type: TabType.antropometryHistory),
        (label: Localizer.l10n(key: "PET_PROFILE_PAGE.VACCINATIONS_TAB_LABEL"), type: TabType.vaccinationHistory)
    ]

    @Published var selectedTab: TabType = .appointmentHistory
}
