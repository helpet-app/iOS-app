//
//  FamilyPageSheetMenuViewModel.swift
//  Helpet
//
//  Created by Efim Nikitin on 26.01.2023.
//

import Foundation

final class FamilyPageSheetMenuViewModel: SheetMenuViewModel {
    enum SheetType: Identifiable {
        var id: Self {
            return self
        }

        case addPet
        case addFamilyMember
        case addFamily
    }

    let imageName = "plus"

    let sheets = [
        (label: Localizer.l10n(key: "FAMILY_PAGE.SHEET_MENU.ADD_PET_LABEL"), imageName: "pawprint", type: SheetType.addPet),
        (label: Localizer.l10n(key: "FAMILY_PAGE.SHEET_MENU.ADD_FAMILY_MEMBER_LABEL"), imageName: "person", type: SheetType.addFamilyMember),
        (label: Localizer.l10n(key: "FAMILY_PAGE.SHEET_MENU.ADD_FAMILY_LABEL"), imageName: "person.2", type: SheetType.addFamily)
    ]

    @Published var selectedSheet: SheetType?
}
