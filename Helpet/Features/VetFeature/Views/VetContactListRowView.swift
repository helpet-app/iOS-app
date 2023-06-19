//
//  VetContactListRowView.swift
//  Helpet
//
//  Created by Efim Nikitin on 02.06.2023.
//

import SwiftUI

struct VetContactListRowView: View {
    let vetContact: VetContact

    var body: some View {
        ListRowView(imageName: "person.text.rectangle", headline: vetContact.name, subheadline: vetContact.value)
    }
}

struct VetContactListRowView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            VetContactListRowView(vetContact: VetContact(id: UUID(),
                                                         name: "Почта",
                                                         value: "example@helpet.com"))
        }
    }
}
