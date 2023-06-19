//
//  AnthropometryPageView.swift
//  Helpet
//
//  Created by Efim Nikitin on 17.06.2023.
//

import SwiftUI

struct AnthropometryPageView: View {
    private let localizedConstants = LocalizedConstants()

    @StateObject private var viewModel: AnthropometryPageViewModel

    @EnvironmentObject private var petViewModel: PetProfilePageViewModel

    @Environment(\.dismiss) private var dismiss

    let anthropometry: PetAnthropometry

    init(anthropometry: PetAnthropometry, pet: Pet) {
        self.anthropometry = anthropometry
        self._viewModel = StateObject(wrappedValue: AnthropometryPageViewModel(pet: pet))
    }

    var height: some View {
        InfoRowView(label: localizedConstants.heightLabel, content: anthropometry.height.formatted())
    }

    var weight: some View {
        InfoRowView(label: localizedConstants.weightLabel, content: anthropometry.weight.formatted())
    }

    var comment: some View {
        InfoRowView(label: localizedConstants.commentLabel, content: anthropometry.comment)
    }

    var body: some View {
        DismissSheet(title: localizedConstants.title) {
            VStack(spacing: DefaultViewConstants.Spacing.large) {
                height

                weight

                comment
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    DeleteButtonView {
                        if await viewModel.deletePetAnthropometry(anthropometry) {
                            petViewModel.antropometryHistory.removeAll(where: { $0.id == anthropometry.id })
                            dismiss()
                        }
                    }
                }
            }
        }
        .requestStatus(viewModel.requestStatus)
    }
}

extension AnthropometryPageView {
    private struct LocalizedConstants {
        let title = Localizer.l10n(key: "PET_ANTHROPOMETRY_PAGE_VIEW.TITLE")

        let heightLabel = Localizer.l10n(key: "PET_ANTHROPOMETRY_PAGE_VIEW.HEIGHT_LABEL")

        let weightLabel = Localizer.l10n(key: "PET_ANTHROPOMETRY_PAGE_VIEW.WEIGHT_LABEL")

        let commentLabel = Localizer.l10n(key: "PET_ANTHROPOMETRY_PAGE_VIEW.COMMENT_LABEL")
    }
}
