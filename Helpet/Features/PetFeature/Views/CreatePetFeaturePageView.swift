//
//  CreatePetFeaturePageView.swift
//  Helpet
//
//  Created by Efim Nikitin on 13.02.2023.
//

import SwiftUI

struct CreatePetFeaturePageView: View {
    private let localizedConstants = LocalizedConstants()

    @StateObject private var viewModel: CreatePetFeaturePageViewModel

    @EnvironmentObject private var petViewModel: PetProfilePageViewModel

    @Environment(\.dismiss) private var dismiss

    init(pet: Pet) {
        self._viewModel = StateObject(wrappedValue: CreatePetFeaturePageViewModel(pet: pet))
    }

    var nameTextField: some View {
        TextField(localizedConstants.nameFieldPlaceholder, text: $viewModel.createPetFeatureInfo.name, axis: .vertical)
            .label(localizedConstants.nameFieldLabel)
    }

    var descriptionTextField: some View {
        TextField(localizedConstants.descriptionFieldPlaceholder, text: $viewModel.createPetFeatureInfo.description, axis: .vertical)
            .label(localizedConstants.descriptionFieldLabel)
    }

    var body: some View {
        CancelDonePageView(title: localizedConstants.title, doneButtonIsEnabled: viewModel.formIsFilled) {
            VStack(spacing: DefaultViewConstants.Spacing.large) {
                nameTextField

                descriptionTextField
            }
        } onDoneTap: {
            if let petFeature = await viewModel.createPetFeature() {
                petViewModel.petFeatures.append(petFeature)
                dismiss()
            }
        }
        .requestStatus(viewModel.requestStatus)
    }
}

extension CreatePetFeaturePageView {
    private struct LocalizedConstants {
        let title = Localizer.l10n(key: "PET_PROFILE_PAGE.NEW_PET_FEATURE.TITLE")

        let nameFieldLabel = Localizer.l10n(key: "PET_PROFILE_PAGE.NEW_PET_FEATURE.NAME_FIELD_LABEL")

        let nameFieldPlaceholder = Localizer.l10n(key: "PET_PROFILE_PAGE.NEW_PET_FEATURE.NAME_FIELD_PLACEHOLDER")

        let descriptionFieldLabel = Localizer.l10n(key: "PET_PROFILE_PAGE.NEW_PET_FEATURE.DESCRIPTION_FIELD_LABEL")

        let descriptionFieldPlaceholder = Localizer.l10n(key: "PET_PROFILE_PAGE.NEW_PET_FEATURE.DESCRIPTION_FIELD_PLACEHOLDER")
    }
}
