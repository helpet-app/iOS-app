//
//  AppearanceSettingsPageView.swift
//  Helpet
//
//  Created by Efim Nikitin on 21.01.2023.
//

import SwiftUI

struct AppearanceSettingsPageView: View {
    private let localizedConstants = LocalizedConstants()

    @StateObject private var colorSchemeState = ColorSchemeState.shared

    var body: some View {
        List {
            Picker(selection: $colorSchemeState.colorScheme) {
                Text(localizedConstants.lightColorSchemeLabel)
                    .tag(UIUserInterfaceStyle.light)

                Text(localizedConstants.darkColorSchemeLabel)
                    .tag(UIUserInterfaceStyle.dark)

                Text(localizedConstants.systemColorSchemeLabel)
                    .tag(UIUserInterfaceStyle.unspecified)
            } label: {
                Text(localizedConstants.colorSchemePickerCaption)
                    .font(.footnote)
            }
            .font(.callout)
            .listRowBackground(Color.Background.secondary)
            .pickerStyle(.inline)
        }
        .listStyle(.insetGrouped)
        .scrollContentBackground(.hidden)
        .background(Color.Background.primary)
        .navigationTitle(localizedConstants.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

extension AppearanceSettingsPageView {
    private struct LocalizedConstants {
        let title = Localizer.l10n(key: "APPEARANCE_SETTINGS_PAGE.TITLE")

        let colorSchemePickerCaption = Localizer.l10n(key: "APPEARANCE_SETTINGS_PAGE.COLOR_SCHEME_PICKER_CAPTION")

        let lightColorSchemeLabel = Localizer.l10n(key: "APPEARANCE_SETTINGS_PAGE.LIGHT_COLOR_SCHEME_LABEL")

        let darkColorSchemeLabel = Localizer.l10n(key: "APPEARANCE_SETTINGS_PAGE.DARK_COLOR_SCHEME_LABEL")

        let systemColorSchemeLabel = Localizer.l10n(key: "APPEARANCE_SETTINGS_PAGE.SYSTEM_COLOR_SCHEME_LABEL")
    }
}

struct AppearanceSettingsPageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AppearanceSettingsPageView()
        }
    }
}
