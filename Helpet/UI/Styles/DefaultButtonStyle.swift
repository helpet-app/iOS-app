//
//  DefaultButtonStyle.swift
//  Helpet
//
//  Created by Efim Nikitin on 17.01.2023.
//

import SwiftUI

struct DefaultButtonStyle: ButtonStyle {
    let isEnabled: Bool

    func makeBody(configuration: Configuration) -> some View {
        return configuration
            .label
            .foregroundColor(isEnabled ? .Foreground.primary : .Foreground.quinary)
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}

extension DefaultButtonStyle {
    init() {
        self.isEnabled = true
    }
}
