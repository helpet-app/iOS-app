//
//  CreateVaccinationPageView.swift
//  Helpet
//
//  Created by Efim Nikitin on 18.02.2023.
//

import SwiftUI

struct CreateVaccinationPageView: View {
    private let localizedConstants = LocalizedConstants()

    @StateObject private var viewModel: CreateVaccinationPageViewModel

    @EnvironmentObject private var petViewModel: PetProfilePageViewModel

    @Environment(\.dismiss) private var dismiss

    init(pet: Pet) {
        self._viewModel = StateObject(wrappedValue: CreateVaccinationPageViewModel(pet: pet))
    }

    var nameTextField: some View {
        TextField(localizedConstants.nameFieldPlaceholder, text: $viewModel.createPetVaccinationInfo.vaccinationName, axis: .vertical)
            .label(localizedConstants.nameFieldLabel)
    }

    var commentTextField: some View {
        TextField(localizedConstants.commentFieldPlaceholder, text: Binding($viewModel.createPetVaccinationInfo.comment), axis: .vertical)
            .label(localizedConstants.commentFieldLabel)
    }

    var dateOfVaccinationPicker: some View {
        DatePicker(localizedConstants.dateOfVaccinationPickerLabel, selection: $viewModel.createPetVaccinationInfo.vaccinatedOn, in: ...Date.now, displayedComponents: [.date])
            .font(.subheadline)
            .padding()
            .background(Color.Background.tertiary)
            .rounded()
            .label(localizedConstants.dateOfVaccinationPickerLabel)
    }

    var body: some View {
        CancelDonePageView(title: localizedConstants.title, doneButtonIsEnabled: viewModel.formIsFilled) {
            VStack(spacing: DefaultViewConstants.Spacing.large) {
                nameTextField

                commentTextField

                dateOfVaccinationPicker
            }
        } onDoneTap: {
            if let petVaccination = await viewModel.createPetVaccination() {
                petViewModel.vaccinationHistory.append(petVaccination)
                dismiss()
            }
        }
        .requestStatus(viewModel.requestStatus)
    }
}

extension CreateVaccinationPageView {
    private struct LocalizedConstants {
        let title = Localizer.l10n(key: "PET_PROFILE_PAGE.NEW_VACCINATION.TITLE")

        let nameFieldLabel = Localizer.l10n(key: "PET_PROFILE_PAGE.NEW_VACCINATION.NAME_FIELD_LABEL")

        let nameFieldPlaceholder = Localizer.l10n(key: "PET_PROFILE_PAGE.NEW_VACCINATION.NAME_FIELD_PLACEHOLDER")

        let commentFieldLabel = Localizer.l10n(key: "PET_PROFILE_PAGE.NEW_VACCINATION.COMMENT_FIELD_LABEL")

        let commentFieldPlaceholder = Localizer.l10n(key: "PET_PROFILE_PAGE.NEW_VACCINATION.COMMENT_FIELD_PLACEHOLDER")

        let dateOfVaccinationPickerLabel = Localizer.l10n(key: "PET_PROFILE_PAGE.NEW_VACCINATION.DATE_OF_VACCINATION_PICKER_LABEL")
    }
}
