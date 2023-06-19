//
//  VetTariff.swift
//  Helpet
//
//  Created by Efim Nikitin on 31.05.2023.
//

import Foundation

struct VetTariff: Identifiable, Codable {
    var id: UUID

    var name: String

    var description: String?

    var minPrice: Double

    var maxPrice: Double
}

extension VetTariff {
    func extractPrice() -> String {
        if minPrice == maxPrice {
            return "\(minPrice.formatted())₽"
        }

        let priceFromLabel = Localizer.l10n(key: "VET_TARIFF.PRICE_FROM_LABEL")

        let priceUpToLabel = Localizer.l10n(key: "VET_TARIFF.PRICE_UP_TO_LABEL")

        return "\(priceFromLabel) \(minPrice.formatted())₽ \(priceUpToLabel) \(maxPrice.formatted())₽"
    }
}
