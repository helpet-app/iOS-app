//
//  VetTariffListRowView.swift
//  Helpet
//
//  Created by Efim Nikitin on 01.06.2023.
//

import SwiftUI

struct VetTariffListRowView: View {
    let vetTariff: VetTariff

    var body: some View {
        ListRowView(imageName: "doc.text.below.ecg", headline: vetTariff.name, subheadline: vetTariff.extractPrice())
    }
}

struct VetTariffListRowView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            // swiftlint:disable:next all
            VetTariffListRowView(vetTariff: VetTariff(id: UUID(), name: "Консультация", description: "Консультация - это возможность обсудить здоровье вашего питомца и получить квалифицированный совет. Независимо от того, нужен ли вам плановый уход или у вас есть особые проблемы, я готова оказать помощь и дать индивидуальные рекомендации для уникальных потребностей вашего питомца.", minPrice: 600, maxPrice: 600))
        }
    }
}
