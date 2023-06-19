//
//  FamilyListRowView.swift
//  Helpet
//
//  Created by Efim Nikitin on 25.01.2023.
//

import SwiftUI

struct FamilyListRowView: View {
    private let localizedConstants = LocalizedConstants()

    let family: Family

    var body: some View {
        ListRowView(imageName: "person.2.circle.fill", headline: family.name, subheadline: extractCreator(from: family))
    }

    private func extractCreator(from family: Family) -> String {
        return "\(localizedConstants.familyCreatedByLabel): \(family.createdBy.name)"
    }
}

extension FamilyListRowView {
    private struct LocalizedConstants {
        let familyCreatedByLabel = Localizer.l10n(key: "FAMILY_PAGE.FAMILY_CREATED_BY_LABEL")
    }
}

struct FamilyListRowView_Previews: PreviewProvider {
    static var previews: some View {
        FamilyListRowView(family: Family(id: UUID(), name: "Семья Ивановых", createdBy: FamilyMember(id: UUID(), username: "p.ivanov", name: "Иванов Петр")))
    }
}
