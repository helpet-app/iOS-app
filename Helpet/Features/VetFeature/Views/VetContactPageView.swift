//
//  VetContactPageView.swift
//  Helpet
//
//  Created by Efim Nikitin on 17.06.2023.
//

import SwiftUI

struct VetContactPageView: View {
    private let localizedConstants = LocalizedConstants()

    let vetContact: VetContact

    var body: some View {
        DismissSheet(title: localizedConstants.title, presentationDetents: [.medium]) {
            InfoRowView(label: vetContact.name, content: vetContact.value)
                .padding()
        }
    }
}

extension VetContactPageView {
    private struct LocalizedConstants {
        let title = Localizer.l10n(key: "VET_CONTACT_PAGE_VIEW.TITLE")
    }
}

struct VetContactPageView_Previews: PreviewProvider {
    static var previews: some View {
        VetContactPageView(vetContact: VetContact(id: UUID(),
                                                  name: "Почта",
                                                  value: "test@helpet.com"))
    }
}
