//
//  ScaledButtonStyle.swift
//  Helpet
//
//  Created by Efim Nikitin on 19.01.2023.
//

import SwiftUI

struct ScaledButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        return configuration
            .label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.interactiveSpring(response: 0.5, dampingFraction: 0.5), value: configuration.isPressed)
    }
}
