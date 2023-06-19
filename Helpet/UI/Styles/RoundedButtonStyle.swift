//
//  RoundedButtonStyle.swift
//  Helpet
//
//  Created by Efim Nikitin on 16.01.2023.
//

import SwiftUI

struct RoundedButtonStyle: ButtonStyle {
    let isEnabled: Bool

    func makeBody(configuration: Configuration) -> some View {
        return configuration
            .label
            .frame(maxWidth: .infinity)
            .padding()
            .foregroundColor(isEnabled ? .Background.primary : .Foreground.quinary)
            .background(isEnabled ? Color.Foreground.primary : Color.Background.quaternary)
            .opacity(configuration.isPressed ? 0.75 : 1)
            .rounded()
            .font(.subheadline.weight(.semibold))
            .animation(.linear(duration: 0.15), value: isEnabled)
            .disabled(!isEnabled)
    }
}

extension RoundedButtonStyle {
    init() {
        self.isEnabled = true
    }
}
