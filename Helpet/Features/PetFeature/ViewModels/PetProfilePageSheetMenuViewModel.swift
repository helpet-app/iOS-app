//
//  PetProfilePageSheetMenuViewModel.swift
//  Helpet
//
//  Created by Efim Nikitin on 26.01.2023.
//

import Foundation

final class PetProfilePageSheetMenuViewModel: SheetMenuViewModel {
    enum SheetType: Identifiable {
        var id: Self {
            return self
        }

        case addPetFeature
        case addDisease
        case addAnthropometry
        case addVaccination
    }

    let imageName = "plus"

    let sheets = [
        (label: Localizer.l10n(key: "PET_PROFILE_PAGE.SHEET_MENU.ADD_PET_FEATURE_LABEL"), imageName: "questionmark.square.dashed", type: SheetType.addPetFeature),
        (label: Localizer.l10n(key: "PET_PROFILE_PAGE.SHEET_MENU.ADD_DISEASE_LABEL"), imageName: "heart.text.square", type: SheetType.addDisease),
        (label: Localizer.l10n(key: "PET_PROFILE_PAGE.SHEET_MENU.ADD_ANTHROPOMETRY_LABEL"), imageName: "square.text.square", type: SheetType.addAnthropometry),
        (label: Localizer.l10n(key: "PET_PROFILE_PAGE.SHEET_MENU.ADD_VACCINATION_LABEL"), imageName: "allergens", type: SheetType.addVaccination)
    ]

    @Published var selectedSheet: SheetType?
}
