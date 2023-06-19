//
//  SettingsPageView.swift
//  Helpet
//
//  Created by Efim Nikitin on 20.01.2023.
//

import SwiftUI

struct SettingsPageView: View {
    private let localizedConstants = LocalizedConstants()

    @StateObject private var viewModel = SettingsPageViewModel()

    var accountManagement: some View {
        SettingsSectionView {
            NavigationLink {
                NotImplementedYetView()
            } label: {
                SettingsRowView(label: localizedConstants.accountManagementLabel, imageName: "person.text.rectangle.fill")
                    .padding(.vertical, DefaultViewConstants.Padding.small)
            }
        }
    }

    var primarySettings: some View {
        SettingsSectionView {
            NavigationLink {
                NotImplementedYetView()
            } label: {
                SettingsRowView(label: localizedConstants.notificationsSettingsLabel, imageName: "bell.fill")
            }

            NavigationLink {
                AppearanceSettingsPageView()
            } label: {
                SettingsRowView(label: localizedConstants.appearanceSettingsLabel, imageName: "circle.lefthalf.filled")
            }

            Link(destination: URL(string: UIApplication.openSettingsURLString)!) {
                SettingsRowView(label: localizedConstants.languageSettingsLabel, imageName: "globe.europe.africa.fill")
            }
        }
    }

    var secondarySettings: some View {
        SettingsSectionView {
            NavigationLink {
                NotImplementedYetView()
            } label: {
                SettingsRowView(label: localizedConstants.feedbackLabel, imageName: "ellipsis.bubble.fill")
            }

            NavigationLink {
                NotImplementedYetView()
            } label: {
                SettingsRowView(label: localizedConstants.privacyPolicyLabel, imageName: "info.circle.fill")
            }
        }
    }

    var signOutButton: some View {
        Button(localizedConstants.signOutButtonLabel) {
            Task {
                await viewModel.signOutButtonTapped()
            }
        }
        .buttonStyle(RoundedButtonStyle())
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: DefaultViewConstants.Spacing.extraLarge) {
                    accountManagement

                    primarySettings

                    secondarySettings

                    signOutButton
                }
                .padding()
            }
            .navigationTitle(localizedConstants.title)
            .navigationBarTitleDisplayMode(.inline)
            .foregroundColor(.Foreground.primary)
            .background(Color.Background.primary)
            .requestStatus(viewModel.requestStatus)
        }
    }
}

extension SettingsPageView {
    private struct LocalizedConstants {
        let title = Localizer.l10n(key: "SETTINGS_PAGE.TITLE")

        let accountManagementLabel = Localizer.l10n(key: "SETTINGS_PAGE.ACCOUNT_MANAGEMENT_LABEL")

        let notificationsSettingsLabel = Localizer.l10n(key: "SETTINGS_PAGE.NOTIFICATIONS_SETTINGS_LABEL")

        let appearanceSettingsLabel = Localizer.l10n(key: "SETTINGS_PAGE.APPEARANCE_SETTINGS_LABEL")

        let languageSettingsLabel = Localizer.l10n(key: "SETTINGS_PAGE.LANGUAGE_SETTINGS_LABEL")

        let feedbackLabel = Localizer.l10n(key: "SETTINGS_PAGE.FEEDBACK_LABEL")

        let privacyPolicyLabel = Localizer.l10n(key: "SETTINGS_PAGE.PRIVACY_POLICY_LABEL")

        let signOutButtonLabel = Localizer.l10n(key: "SETTINGS_PAGE.SIGN_OUT_BUTTON_LABEL")
    }
}

struct SettingsPageView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsPageView()
    }
}
