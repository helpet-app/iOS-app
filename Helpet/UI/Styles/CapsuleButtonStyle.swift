//
//  CapsuleButtonStyle.swift
//  Helpet
//
//  Created by Efim Nikitin on 08.05.2023.
//

import SwiftUI

struct CapsuleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        return configuration
            .label
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
            .foregroundColor(.Background.primary)
            .background(Color.Foreground.primary)
            .opacity(configuration.isPressed ? 0.75 : 1)
            .clipShape(Capsule(style: .continuous))
            .font(.subheadline.weight(.medium))
    }
}
