//
//  SignUpPageView.swift
//  Helpet
//
//  Created by Efim Nikitin on 17.01.2023.
//

import SwiftUI

struct SignUpPageView: View {
    private let localizedConstants = LocalizedConstants()

    @StateObject private var viewModel = SignUpPageViewModel()

    @EnvironmentObject private var notificationHandler: NotificationHandler

    var title: some View {
        Text(localizedConstants.title)
            .fontWeight(.bold)
            .foregroundColor(.Foreground.primary)
            .padding(.bottom, DefaultViewConstants.Padding.medium)
    }

    var nameTextField: some View {
        TextField(localizedConstants.nameFieldPlaceholder, text: $viewModel.signUpInfo.name)
            .textContentType(.name)
            .textInputAutocapitalization(.words)
    }

    var emailTextField: some View {
        TextField(localizedConstants.emailFieldPlaceholder, text: $viewModel.signUpInfo.email)
            .textContentType(.username)
            .keyboardType(.emailAddress)
    }

    var usernameTextField: some View {
        TextField(localizedConstants.usernameFieldPlaceholder, text: $viewModel.signUpInfo.username)
            .textContentType(.username)
    }

    var passwordTextField: some View {
        SecureField(localizedConstants.passwordFieldPlaceholder, text: $viewModel.signUpInfo.password)
            .textContentType(.newPassword)
    }

    var confirmPasswordTextField: some View {
        SecureField(localizedConstants.confirmPasswordFieldPlaceholder, text: $viewModel.signUpInfo.confirmPassword)
            .textContentType(.newPassword)
    }

    var baseInfoForm: some View {
        VStack {
            VStack(spacing: DefaultViewConstants.Spacing.extraSmall) {
                nameTextField

                emailTextField
            }
            .textFieldStyle(DefaultTextFieldStyle())
            .rounded()

            Spacer()
        }
    }

    var credentialsForm: some View {
        VStack {
            VStack(spacing: DefaultViewConstants.Spacing.extraSmall) {
                usernameTextField

                passwordTextField

                confirmPasswordTextField
            }
            .textFieldStyle(DefaultTextFieldStyle())
            .rounded()

            Spacer()
        }
    }

    var signUpForm: some View {
        TabView {
            Group {
                baseInfoForm

                credentialsForm
            }
            .padding(.horizontal)
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .textInputAutocapitalization(.never)
        .autocorrectionDisabled(true)
    }

    var signUpButton: some View {
        Button(localizedConstants.signUpButtonLabel) {
            Task {
                await viewModel.signUpButtonTapped()
            }
        }
        .buttonStyle(RoundedButtonStyle(isEnabled: viewModel.formIsFilled))
        .disabled(!viewModel.formIsFilled)
        .padding(.horizontal)
    }

    var body: some View {
        VStack {
            Spacer()

            VStack(spacing: DefaultViewConstants.Spacing.medium) {
                AppLogoView()

                title

                signUpForm
            }

            Spacer()

            signUpButton
        }
        .padding(.bottom, DefaultViewConstants.Padding.medium)
        .background(Color.Background.primary.ignoresSafeArea(.all))
        .ignoresSafeArea(.keyboard)
        .requestStatus(viewModel.requestStatus)
    }
}

extension SignUpPageView {
    private struct LocalizedConstants {
        let title = Localizer.l10n(key: "SIGN_UP_PAGE.TITLE")

        let nameFieldPlaceholder = Localizer.l10n(key: "SIGN_UP_PAGE.FULL_NAME_FIELD_PLACEHOLDER")

        let emailFieldPlaceholder = Localizer.l10n(key: "SIGN_UP_PAGE.EMAIL_FIELD_PLACEHOLDER")

        let usernameFieldPlaceholder = Localizer.l10n(key: "SIGN_UP_PAGE.USERNAME_FIELD_PLACEHOLDER")

        let passwordFieldPlaceholder = Localizer.l10n(key: "SIGN_UP_PAGE.PASSWORD_FIELD_PLACEHOLDER")

        let confirmPasswordFieldPlaceholder = Localizer.l10n(key: "SIGN_UP_PAGE.CONFIRM_PASSWORD_FIELD_PLACEHOLDER")

        let signUpButtonLabel = Localizer.l10n(key: "SIGN_UP_PAGE.SIGN_UP_BUTTON_LABEL")
    }
}

struct SignUpPageView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpPageView()
    }
}
