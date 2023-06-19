//
//  PetFeatureListRowView.swift
//  Helpet
//
//  Created by Efim Nikitin on 02.02.2023.
//

import SwiftUI

struct PetFeatureListRowView: View {
    let petFeature: PetFeature

    var body: some View {
        ListRowView(imageName: "questionmark.app.dashed", headline: petFeature.name, subheadline: petFeature.description)
    }
}

struct PetFeatureListRowView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PetFeatureListRowView(petFeature: PetFeature(id: UUID(), name: "Окрас", description: "Рыжий", createdAt: Date()))
        }
    }
}
