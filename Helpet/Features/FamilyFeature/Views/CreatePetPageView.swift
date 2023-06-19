//
//  CreatePetPageView.swift
//  Helpet
//
//  Created by Efim Nikitin on 07.06.2023.
//

import SwiftUI

struct CreatePetPageView: View {
    private let localizedConstants = LocalizedConstants()

    @StateObject private var viewModel = CreatePetPageViewModel()

    @EnvironmentObject private var familyPageViewModel: FamilyPageViewModel

    @Environment(\.dismiss) private var dismiss

    var nameTextField: some View {
        TextField(localizedConstants.nameFieldPlaceholder, text: $viewModel.createPetInfo.name, axis: .vertical)
            .label(localizedConstants.nameFieldLabel)
    }

    var petCategoryPicker: some View {
        PetCategoryPickerView(selectedCategory: $viewModel.createPetInfo.petCategory)
            .label(localizedConstants.petCategoryPickerLabel)
    }

    var body: some View {
        CancelDonePageView(title: localizedConstants.title, doneButtonIsEnabled: viewModel.formIsFilled) {
            VStack(spacing: DefaultViewConstants.Spacing.large) {
                nameTextField

                petCategoryPicker
            }
        } onDoneTap: {
            if let pet = await viewModel.createPet() {
                familyPageViewModel.pets.append(pet)
                dismiss()
            }
        }
        .requestStatus(viewModel.requestStatus)
    }
}

extension CreatePetPageView {
    private struct LocalizedConstants {
        let title = Localizer.l10n(key: "FAMILY_PAGE.CREATE_PET.TITLE")

        let nameFieldLabel = Localizer.l10n(key: "FAMILY_PAGE.CREATE_PET.NAME_FIELD_LABEL")

        let nameFieldPlaceholder = Localizer.l10n(key: "FAMILY_PAGE.CREATE_PET.NAME_FIELD_LABEL")

        let petCategoryPickerLabel = Localizer.l10n(key: "FAMILY_PAGE.CREATE_PET.PET_CATEGORY_PICKER_LABEL")
    }
}

struct CreatePetPageView_Previews: PreviewProvider {
    static var previews: some View {
        FamilyPageView()
    }
}
