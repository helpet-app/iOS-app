//
//  ForgotPasswordPageView.swift
//  Helpet
//
//  Created by Efim Nikitin on 18.01.2023.
//

import SwiftUI

struct ForgotPasswordPageView: View {
    private let localizedConstants = LocalizedConstants()

    @StateObject private var viewModel = ForgotPasswordPageViewModel()

    var title: some View {
        Text(localizedConstants.title)
            .fontWeight(.bold)
            .foregroundColor(.Foreground.primary)
            .padding(.bottom, DefaultViewConstants.Padding.medium)
    }

    var emailTextField: some View {
        TextField(localizedConstants.emailFieldPlaceholder, text: $viewModel.forgotPasswordInfo.email)
            .textFieldStyle(RoundedTextFieldStyle())
            .textContentType(.username)
            .keyboardType(.emailAddress)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled(true)
    }

    var recoverPasswordButton: some View {
        Button(localizedConstants.recoverPasswordButtonLabel) {
            Task {
                await viewModel.recoverPasswordButtonTapped()
            }
        }
        .buttonStyle(RoundedButtonStyle(isEnabled: viewModel.formIsFilled))
        .disabled(!viewModel.formIsFilled)
    }

    var body: some View {
        VStack {
            Spacer()

            VStack(spacing: DefaultViewConstants.Spacing.medium) {
                AppLogoView()

                title

                emailTextField

                Spacer()
            }

            recoverPasswordButton
        }
        .padding(.horizontal)
        .padding(.bottom, DefaultViewConstants.Padding.medium)
        .background(Color.Background.primary.ignoresSafeArea(.all))
        .ignoresSafeArea(.keyboard)
    }
}

extension ForgotPasswordPageView {
    private struct LocalizedConstants {
        let title = Localizer.l10n(key: "FORGOT_PASSWORD_PAGE.TITLE")

        let emailFieldPlaceholder = Localizer.l10n(key: "FORGOT_PASSWORD_PAGE.EMAIL_FIELD_PLACEHOLDER")

        let recoverPasswordButtonLabel = Localizer.l10n(key: "FORGOT_PASSWORD_PAGE.RECOVER_PASSWORD_BUTTON_LABEL")
    }
}

struct ForgotPasswordPageView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordPageView()
    }
}
