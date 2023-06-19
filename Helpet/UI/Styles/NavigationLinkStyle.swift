//
//  NavigationLinkStyle.swift
//  Helpet
//
//  Created by Efim Nikitin on 22.01.2023.
//

import SwiftUI

struct NavigationLinkStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        return configuration
            .label
            .frame(maxWidth: .infinity)
            .background(configuration.isPressed ? Color.Background.tertiary : Color.Background.secondary)
    }
}
