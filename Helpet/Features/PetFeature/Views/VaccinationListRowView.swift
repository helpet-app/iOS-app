//
//  VaccinationListRowView.swift
//  Helpet
//
//  Created by Efim Nikitin on 02.02.2023.
//

import SwiftUI

struct VaccinationListRowView: View {
    let vaccination: PetVaccination

    var body: some View {
        ListRowView(imageName: "allergens", headline: vaccination.vaccinationName, subheadline: extractSubheadline(from: vaccination))
    }

    private func extractSubheadline(from vaccination: PetVaccination) -> String {
        let vaccinatedOn = vaccination.vaccinatedOn.formatted(.dateTime.day().month(.wide).year())

        if let comment = vaccination.comment {
            return "\(vaccinatedOn), \(comment)"
        }

        return vaccinatedOn
    }
}

struct VaccinationListRowView_Previews: PreviewProvider {
    static var previews: some View {
        VaccinationListRowView(vaccination: PetVaccination(id: UUID(), vaccinationName: "Рабиес", vaccinatedOn: Date(), createdAt: Date()))
    }
}
