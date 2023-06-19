//
//  ColorSchemeState.swift
//  Helpet
//
//  Created by Efim Nikitin on 21.01.2023.
//

import SwiftUI

final class ColorSchemeState: ObservableObject {
    @AppStorage("colorScheme") var colorScheme: UIUserInterfaceStyle = .light {
        didSet {
            applyColorScheme()
        }
    }

    static let shared = ColorSchemeState()

    private init() {}

    func applyColorScheme() {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }

        for window in scene.windows {
            window.overrideUserInterfaceStyle = colorScheme
        }
    }
}
