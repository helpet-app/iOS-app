//
//  UserProfilePageView.swift
//  Helpet
//
//  Created by Efim Nikitin on 20.01.2023.
//

import SwiftUI

struct UserProfilePageView: View {
    private let localizedConstants = LocalizedConstants()

    @StateObject private var viewModel = UserProfilePageViewModel()

    @State private var settingsSheetIsShown: Bool = false

    @State private var editProfileSheetIsShown: Bool = false

    var settingsButton: some View {
        Button {
            settingsSheetIsShown = true
        } label: {
            Image(systemName: "gearshape.fill")
                .font(.body.weight(.bold))
        }
        .sheet(isPresented: $settingsSheetIsShown) {
            SettingsPageView()
        }
    }

    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                if let _ = viewModel.profile {
                    UserProfileView(profile: Binding($viewModel.profile)!)
                }
            }
            .foregroundColor(.Foreground.primary)
            .refreshable {
                await viewModel.fetchProfile()
            }
            .fetchStatus(viewModel.requestStatus) {
                await viewModel.fetchProfile()
            }
        }
        .background(Color.Background.primary.ignoresSafeArea(.all))
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                settingsButton
            }
        }
        .animation(.default, value: viewModel.profile == nil)
    }
}

extension UserProfilePageView {
    private struct LocalizedConstants {
        let emailLabel = Localizer.l10n(key: "USER_PROFILE_PAGE.EMAIL_LABEL")

        let usernameLabel = Localizer.l10n(key: "USER_PROFILE_PAGE.USERNAME_LABEL")

        let editButtonLabel = Localizer.l10n(key: "USER_PROFILE_PAGE.EDIT_BUTTON_LABEL")
    }
}

struct UserProfilePageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            UserProfilePageView()
                .navigationTitle("Profile")
        }
    }
}
