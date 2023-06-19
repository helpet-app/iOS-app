//
//  UserProfileView.swift
//  Helpet
//
//  Created by Efim Nikitin on 20.01.2023.
//

import SwiftUI

struct UserProfileView: View {
    private let localizedConstants = LocalizedConstants()

    @State private var editProfileSheetIsShown = false

    @Binding var profile: Profile

    var profileImage: some View {
        Image(systemName: "person.crop.circle.fill")
            .font(.system(size: 100))
    }

    var name: some View {
        Text(profile.name)
            .font(.title3)
            .fontWeight(.semibold)
    }

    var infoCard: some View {
        VStack(spacing: DefaultViewConstants.Spacing.medium) {
            CardView {
                CardRowView(image: Image(systemName: "person.crop.square.filled.and.at.rectangle.fill"),
                            name: localizedConstants.usernameLabel,
                            value: profile.username)

                CardRowView(image: Image(systemName: "envelope.badge.fill"),
                            name: localizedConstants.emailLabel,
                            value: profile.email)
            }

            if !profile.isEmailVerified {
                CardView {
                    CardRowView(image: Image(systemName: "exclamationmark.circle.fill"), name: localizedConstants.emailIsNotVerifiedTitle, value: "")
                }
            }
        }
    }

    var editButton: some View {
        Button(localizedConstants.editButtonLabel) {
            editProfileSheetIsShown = true
        }
        .sheet(isPresented: $editProfileSheetIsShown) {
            EditProfilePageView(profile: $profile)
        }
        .buttonStyle(RoundedButtonStyle())
    }

    var body: some View {
        VStack(spacing: DefaultViewConstants.Spacing.medium) {
            profileImage

            name

            infoCard

            editButton
        }
        .padding(.horizontal)
    }
}

extension UserProfileView {
    private struct LocalizedConstants {
        let emailLabel = Localizer.l10n(key: "USER_PROFILE_PAGE.EMAIL_LABEL")

        let usernameLabel = Localizer.l10n(key: "USER_PROFILE_PAGE.USERNAME_LABEL")

        let editButtonLabel = Localizer.l10n(key: "USER_PROFILE_PAGE.EDIT_BUTTON_LABEL")

        let emailIsNotVerifiedTitle = Localizer.l10n(key: "USER_PROFILE_PAGE.EMAIL_IS_NOT_VERIFIED_MESSAGE")
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            UserProfilePageView()
        }
    }
}
