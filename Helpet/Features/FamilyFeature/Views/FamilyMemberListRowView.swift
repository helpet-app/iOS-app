//
//  FamilyMemberListRowView.swift
//  Helpet
//
//  Created by Efim Nikitin on 25.01.2023.
//

import SwiftUI

struct FamilyMemberListRowView: View {
    let familyMember: FamilyMember

    var body: some View {
        ListRowView(imageName: "person.crop.circle.fill", headline: familyMember.name, subheadline: familyMember.username)
    }
}

struct FamilyMemberListRowView_Previews: PreviewProvider {
    static var previews: some View {
        FamilyMemberListRowView(familyMember: FamilyMember(id: UUID(), username: "p.ivanov", name: "Иванов Петр"))
    }
}
