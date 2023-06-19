//
//  CreateDiseasePageView.swift
//  Helpet
//
//  Created by Efim Nikitin on 17.02.2023.
//

import SwiftUI

struct CreateDiseasePageView: View {
    private let localizedConstants = LocalizedConstants()

    @StateObject private var viewModel: CreateDiseasePageViewModel

    @EnvironmentObject private var petViewModel: PetProfilePageViewModel

    @Environment(\.dismiss) private var dismiss

    init(pet: Pet) {
        self._viewModel = StateObject(wrappedValue: CreateDiseasePageViewModel(pet: pet))
    }

    var nameTextField: some View {
        TextField(localizedConstants.nameFieldPlaceholder, text: $viewModel.createPetDiseaseInfo.diseaseName, axis: .vertical)
            .label(localizedConstants.nameFieldLabel)
    }

    var commentTextField: some View {
        TextField(localizedConstants.commentFieldPlaceholder, text: Binding($viewModel.createPetDiseaseInfo.comment), axis: .vertical)
            .label(localizedConstants.commentFieldLabel)
    }

    var dateOfIllnessPicker: some View {
        DatePicker(localizedConstants.dateOfIllnessPickerLabel, selection: $viewModel.createPetDiseaseInfo.gotSickOn, in: ...Date.now, displayedComponents: [.date])
            .font(.subheadline)
            .padding()
            .background(Color.Background.tertiary)
            .rounded()
            .label(localizedConstants.dateOfIllnessPickerLabel)
    }

    var dateOfRecoveryPicker: some View {
        VStack(spacing: DefaultViewConstants.Spacing.medium) {
            Toggle(localizedConstants.alreadyRecoveredToggleLabel, isOn: $viewModel.createPetDiseaseInfo.alreadyRecovered)
                // .tint(Color.Foreground.quinary)

            if viewModel.createPetDiseaseInfo.alreadyRecovered {
                Divider()

                DatePicker(localizedConstants.dateOfRecoveryPickerLabel, selection: $viewModel.createPetDiseaseInfo.recoveredOn, in: ...Date.now, displayedComponents: [.date])
            }
        }
        .font(.subheadline)
        .padding()
        .background(Color.Background.tertiary)
        .rounded()
        .label(localizedConstants.dateOfRecoveryPickerLabel)
    }

    var body: some View {
        CancelDonePageView(title: localizedConstants.title, doneButtonIsEnabled: viewModel.formIsFilled) {
            VStack(spacing: DefaultViewConstants.Spacing.large) {
                nameTextField

                commentTextField

                dateOfIllnessPicker

                dateOfRecoveryPicker
            }
        } onDoneTap: {
            if let petDisease = await viewModel.createPetDisease() {
                petViewModel.diseaseHistory.append(petDisease)
                dismiss()
            }
        }
        .requestStatus(viewModel.requestStatus)
    }
}

extension CreateDiseasePageView {
    private struct LocalizedConstants {
        let title = Localizer.l10n(key: "PET_PROFILE_PAGE.NEW_DISEASE.TITLE")

        let nameFieldLabel = Localizer.l10n(key: "PET_PROFILE_PAGE.NEW_DISEASE.NAME_FIELD_LABEL")

        let nameFieldPlaceholder = Localizer.l10n(key: "PET_PROFILE_PAGE.NEW_DISEASE.NAME_FIELD_PLACEHOLDER")

        let commentFieldLabel = Localizer.l10n(key: "PET_PROFILE_PAGE.NEW_DISEASE.COMMENT_FIELD_LABEL")

        let commentFieldPlaceholder = Localizer.l10n(key: "PET_PROFILE_PAGE.NEW_DISEASE.COMMENT_FIELD_PLACEHOLDER")

        let dateOfIllnessPickerLabel = Localizer.l10n(key: "PET_PROFILE_PAGE.NEW_DISEASE.DATE_OF_ILLNESS_PICKER_LABEL")

        let alreadyRecoveredToggleLabel = Localizer.l10n(key: "PET_PROFILE_PAGE.NEW_DISEASE.ALREADY_RECOVERED_TOGGLE_LABEL")

        let dateOfRecoveryPickerLabel = Localizer.l10n(key: "PET_PROFILE_PAGE.NEW_DISEASE.DATE_OF_RECOVERY_PICKER_LABEL")
    }
}
