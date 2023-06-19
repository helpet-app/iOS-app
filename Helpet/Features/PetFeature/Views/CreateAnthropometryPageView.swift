//
//  CreateAnthropometryPageView.swift
//  Helpet
//
//  Created by Efim Nikitin on 13.02.2023.
//

import SwiftUI

struct CreateAnthropometryPageView: View {
    private let localizedConstants = LocalizedConstants()

    @StateObject private var viewModel: CreateAnthropometryPageViewModel

    @EnvironmentObject private var petViewModel: PetProfilePageViewModel

    @Environment(\.dismiss) private var dismiss

    init(pet: Pet) {
        self._viewModel = StateObject(wrappedValue: CreateAnthropometryPageViewModel(pet: pet))
    }

    var heightTextField: some View {
        TextField("0", value: $viewModel.createPetAnthropometryInfo.height, format: .number)
            .keyboardType(.decimalPad)
            .label(localizedConstants.heightFieldLabel)
    }

    var weightTextField: some View {
        TextField("0", value: $viewModel.createPetAnthropometryInfo.weight, format: .number)
            .keyboardType(.decimalPad)
            .label(localizedConstants.weightFieldLabel)
    }

    var commentTextField: some View {
        TextField(localizedConstants.commentFieldPlaceholder, text: Binding($viewModel.createPetAnthropometryInfo.comment), axis: .vertical)
            .label(localizedConstants.commentFieldLabel)
    }

    var body: some View {
        CancelDonePageView(title: localizedConstants.title, doneButtonIsEnabled: viewModel.formIsFilled) {
            VStack(spacing: DefaultViewConstants.Spacing.large) {
                heightTextField

                weightTextField

                commentTextField
            }
        } onDoneTap: {
            if let petAnthropometry = await viewModel.createPetAnthropometry() {
                petViewModel.antropometryHistory.append(petAnthropometry)
                dismiss()
            }
        }
        .requestStatus(viewModel.requestStatus)
    }
}

extension CreateAnthropometryPageView {
    private struct LocalizedConstants {
        let title = Localizer.l10n(key: "PET_PROFILE_PAGE.NEW_ANTHROPOMETRY.TITLE")

        let heightFieldLabel = Localizer.l10n(key: "PET_PROFILE_PAGE.NEW_ANTHROPOMETRY.HEIGHT_FIELD_LABEL")

        let heightFieldPlaceholder = Localizer.l10n(key: "PET_PROFILE_PAGE.NEW_ANTHROPOMETRY.HEIGHT_FIELD_PLACEHOLDER")

        let weightFieldLabel = Localizer.l10n(key: "PET_PROFILE_PAGE.NEW_ANTHROPOMETRY.WEIGHT_FIELD_LABEL")

        let weightFieldPlaceholder = Localizer.l10n(key: "PET_PROFILE_PAGE.NEW_ANTHROPOMETRY.WEIGHT_FIELD_PLACEHOLDER")

        let commentFieldLabel = Localizer.l10n(key: "PET_PROFILE_PAGE.NEW_ANTHROPOMETRY.COMMENT_FIELD_LABEL")

        let commentFieldPlaceholder = Localizer.l10n(key: "PET_PROFILE_PAGE.NEW_ANTHROPOMETRY.COMMENT_FIELD_PLACEHOLDER")
    }
}
