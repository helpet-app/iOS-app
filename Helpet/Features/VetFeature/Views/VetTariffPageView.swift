//
//  VetTariffPageView.swift
//  Helpet
//
//  Created by Efim Nikitin on 17.06.2023.
//

import SwiftUI

struct VetTariffPageView: View {
    private let localizedConstants = LocalizedConstants()

    let vetTariff: VetTariff

    var name: some View {
        InfoRowView(label: localizedConstants.nameLabel, content: vetTariff.name)
    }

    var description: some View {
        InfoRowView(label: localizedConstants.descriptionLabel, content: vetTariff.description)
    }

    var price: some View {
        InfoRowView(label: localizedConstants.priceLabel, content: vetTariff.extractPrice())
    }

    var body: some View {
        DismissSheet(title: localizedConstants.title) {
            VStack(spacing: DefaultViewConstants.Spacing.large) {
                name

                description

                price
            }
            .padding()
        }
    }
}

extension VetTariffPageView {
    private struct LocalizedConstants {
        let title = Localizer.l10n(key: "VET_TARIFF_PAGE_VIEW.TITLE")

        let nameLabel = Localizer.l10n(key: "VET_TARIFF_PAGE_VIEW.NAME_LABEL")

        let descriptionLabel = Localizer.l10n(key: "VET_TARIFF_PAGE_VIEW.DESCRIPTION_LABEL")

        let priceLabel = Localizer.l10n(key: "VET_TARIFF_PAGE_VIEW.PRICE_LABEL")
    }
}

struct VetTariffPageView_Previews: PreviewProvider {
    static var previews: some View {
        VetTariffPageView(vetTariff: VetTariff(id: UUID(),
                                               name: "Консультация по питанию",
                                               description: "Обсуждение рациона питания вашего питомца",
                                               minPrice: 500,
                                               maxPrice: 1000))
    }
}
