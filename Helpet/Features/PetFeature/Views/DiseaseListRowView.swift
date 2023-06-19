//
//  DiseaseListRowView.swift
//  Helpet
//
//  Created by Efim Nikitin on 02.02.2023.
//

import SwiftUI

struct DiseaseListRowView: View {
    let disease: PetDisease

    var body: some View {
        ListRowView(imageName: "heart.text.square", headline: disease.diseaseName, subheadline: extractSubheadline(from: disease))
    }

    private func extractSubheadline(from disease: PetDisease) -> String {
        let gotSickOn = disease.gotSickOn.formatted(.dateTime.day().month(.wide).year())

        if let comment = disease.comment {
            return "\(gotSickOn), \(comment)"
        }

        return gotSickOn
    }
}

struct DiseaseListRowView_Previews: PreviewProvider {
    static var previews: some View {
        DiseaseListRowView(disease: PetDisease(id: UUID(), diseaseName: "Болела задняя правая лапка", gotSickOn: Date(), createdAt: Date()))
    }
}
