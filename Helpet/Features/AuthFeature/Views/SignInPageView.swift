//
//  SignInPageView.swift
//  Helpet
//
//  Created by Efim Nikitin on 16.01.2023.
//

import SwiftUI

struct SignInPageView: View {
    private let localizedConstants = LocalizedConstants()

    @StateObject private var viewModel = SignInPageViewModel()

    var title: some View {
        Text(localizedConstants.title)
            .fontWeight(.bold)
            .foregroundColor(.Foreground.primary)
            .padding(.bottom, DefaultViewConstants.Padding.medium)
    }

    var usernameTextField: some View {
        TextField(localizedConstants.usernameFieldPlaceholder, text: $viewModel.signInInfo.username)
            .textContentType(.username)
            .keyboardType(.emailAddress)
    }

    var passwordTextField: some View {
        SecureField(localizedConstants.passwordFieldPlaceholder, text: $viewModel.signInInfo.password)
            .textContentType(.password)
    }

    var signInForm: some View {
        VStack(spacing: DefaultViewConstants.Spacing.extraSmall) {
            usernameTextField

            passwordTextField
        }
        .textFieldStyle(DefaultTextFieldStyle())
        .textInputAutocapitalization(.never)
        .autocorrectionDisabled(true)
        .rounded()
    }

    var forgotPasswordButton: some View {
        HStack {
            Spacer()

            NavigationLink {
                ForgotPasswordPageView()
            } label: {
                Text(localizedConstants.forgotPasswordButtonLabel)
                    .font(.subheadline)
                    .foregroundColor(.Foreground.quinary)
            }
            .buttonStyle(DefaultButtonStyle())
            .font(.subheadline)
        }
    }

    var signInButton: some View {
        Button(localizedConstants.signInButtonLabel) {
            Task {
                await viewModel.signInButtonTapped()
            }
        }
        .buttonStyle(RoundedButtonStyle(isEnabled: viewModel.formIsFilled))
        .disabled(!viewModel.formIsFilled)
    }

    var signUpButton: some View {
        NavigationLink {
            SignUpPageView()
        } label: {
            Text(localizedConstants.signUpButtonLabel)
                .foregroundColor(.Foreground.quinary)
        }
        .buttonStyle(DefaultButtonStyle())
        .font(.subheadline)
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: DefaultViewConstants.Spacing.medium) {
                Spacer()

                AppLogoView()

                title

                signInForm

                forgotPasswordButton

                Spacer()

                signInButton

                signUpButton
            }
            .navigationTitle(localizedConstants.title)
            .toolbar(.hidden, for: .navigationBar)
            .padding(.horizontal)
            .padding(.bottom, DefaultViewConstants.Padding.medium)
            .background(Color.Background.primary.ignoresSafeArea(.all))
            .ignoresSafeArea(.keyboard)
            .requestStatus(viewModel.requestStatus)
        }
    }
}

extension SignInPageView {
    private struct LocalizedConstants {
        let title = Localizer.l10n(key: "SIGN_IN_PAGE.TITLE")

        let usernameFieldPlaceholder = Localizer.l10n(key: "SIGN_IN_PAGE.USERNAME_FIELD_PLACEHOLDER")

        let passwordFieldPlaceholder = Localizer.l10n(key: "SIGN_IN_PAGE.PASSWORD_FIELD_PLACEHOLDER")

        let forgotPasswordButtonLabel = Localizer.l10n(key: "SIGN_IN_PAGE.FORGOT_PASSWORD_BUTTON_LABEL")

        let signInButtonLabel = Localizer.l10n(key: "SIGN_IN_PAGE.SIGN_IN_BUTTON_LABEL")

        let signUpButtonLabel = Localizer.l10n(key: "SIGN_IN_PAGE.SIGN_UP_BUTTON_LABEL")
    }
}

struct SignInPageView_Previews: PreviewProvider {
    static var previews: some View {
        SignInPageView()
    }
}
