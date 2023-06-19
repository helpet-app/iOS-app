//
//  AnthropometryListRowView.swift
//  Helpet
//
//  Created by Efim Nikitin on 02.02.2023.
//

import SwiftUI

struct AnthropometryListRowView: View {
    private let localizedConstants = LocalizedConstants()

    let anthropometry: PetAnthropometry

    var body: some View {
        ListRowView(imageName: "square.text.square", headline: extractHeadline(from: anthropometry), subheadline: extractSubheadline(from: anthropometry))
    }

    private func extractHeadline(from anthropometry: PetAnthropometry) -> String {
        let heightInfo = "\(localizedConstants.heightLabel): \(anthropometry.height.formatted(numberOfDigits: 1))"

        let weightInfo = "\(localizedConstants.weightLabel): \(anthropometry.weight.formatted(numberOfDigits: 1))"

        return "\(heightInfo) • \(weightInfo)"
    }

    private func extractSubheadline(from anthropometry: PetAnthropometry) -> String {
        let createdAt = anthropometry.createdAt.formatted(.dateTime.day().month(.wide).year())

        if let comment = anthropometry.comment {
            return "\(createdAt), \(comment)"
        }

        return createdAt
    }
}

extension AnthropometryListRowView {
    private struct LocalizedConstants {
        let heightLabel = Localizer.l10n(key: "PET_PROFILE_PAGE.ANTHROPOMETRY_TAB.HEIGHT_LABEL")

        let weightLabel = Localizer.l10n(key: "PET_PROFILE_PAGE.ANTHROPOMETRY_TAB.WEIGHT_LABEL")
    }
}

struct AnthropometryListRowView_Previews: PreviewProvider {
    static var previews: some View {
        AnthropometryListRowView(anthropometry: PetAnthropometry(id: UUID(), height: 0, weight: 0, createdAt: Date()))
    }
}
