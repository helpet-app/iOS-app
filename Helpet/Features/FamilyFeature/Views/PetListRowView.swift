//
//  PetListRowView.swift
//  Helpet
//
//  Created by Efim Nikitin on 25.01.2023.
//

import SwiftUI

struct PetListRowView: View {
    let pet: Pet

    var name: some View {
        HStack(spacing: 0) {
            Text(pet.name)
                .fontWeight(.semibold)
                .foregroundColor(.Foreground.primary)

            if let family = pet.family {
                Text(", \(family.name)")
            }
        }
        .font(.subheadline)
    }

    @ViewBuilder
    var category: some View {
        Group {
            if let species = pet.species {
                Text(species.name)
            } else if let petCategory = pet.petCategory {
                Text(petCategory.name)
            }
        }
        .font(.footnote)
    }

    var body: some View {
        ListRowView(imageName: "pawprint.circle.fill") {
            VStack(alignment: .leading, spacing: DefaultViewConstants.Spacing.extraSmall) {
                name

                category
            }
            .foregroundColor(.Foreground.quinary)
        }
    }
}

struct PetListRowView_Previews: PreviewProvider {
    static var previews: some View {
        PetListRowView(pet: Pet(id: UUID(), name: "Рыжик"))
    }
}
