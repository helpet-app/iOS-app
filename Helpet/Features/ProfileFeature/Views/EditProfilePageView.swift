//
//  EditProfilePageView.swift
//  Helpet
//
//  Created by Efim Nikitin on 23.01.2023.
//

import SwiftUI

struct EditProfilePageView: View {
    private let localizedConstants = LocalizedConstants()

    @StateObject private var viewModel: EditProfilePageViewModel

    @Environment(\.dismiss) private var dismiss

    @Binding var profile: Profile

    init(profile: Binding<Profile>) {
        self._profile = profile
        self._viewModel = StateObject(wrappedValue: EditProfilePageViewModel(profile: profile.wrappedValue))
    }

    var nameTextField: some View {
        TextField(localizedConstants.nameFieldPlaceholder, text: $viewModel.editProfileInfo.name)
            .textContentType(.name)
            .textInputAutocapitalization(.words)
            .label(localizedConstants.nameFieldLabel)
    }

    var usernameTextField: some View {
        TextField(localizedConstants.usernameFieldPlaceholder, text: $viewModel.editProfileInfo.username)
            .textContentType(.username)
            .label(localizedConstants.usernameFieldLabel)
    }

    var body: some View {
        CancelDonePageView(doneButtonIsEnabled: viewModel.formIsFilled) {
            VStack(spacing: DefaultViewConstants.Spacing.large) {
                nameTextField

                usernameTextField
            }
        } onDoneTap: {
            if let profile = await viewModel.updateProfile() {
                self.profile = profile
                dismiss()
            }
        }
        .requestStatus(viewModel.requestStatus)
    }
}

extension EditProfilePageView {
    private struct LocalizedConstants {
        let nameFieldLabel = Localizer.l10n(key: "EDIT_PROFILE_PAGE.FULL_NAME_FIELD_LABEL")

        let nameFieldPlaceholder = Localizer.l10n(key: "EDIT_PROFILE_PAGE.FULL_NAME_FIELD_PLACEHOLDER")

        let usernameFieldLabel = Localizer.l10n(key: "EDIT_PROFILE_PAGE.USERNAME_FIELD_LABEL")

        let usernameFieldPlaceholder = Localizer.l10n(key: "EDIT_PROFILE_PAGE.USERNAME_FIELD_PLACEHOLDER")
    }
}

struct EditProfilePageView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfilePageView()
    }
}
