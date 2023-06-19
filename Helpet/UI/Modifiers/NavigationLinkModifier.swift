//
//  NavigationLinkModifier.swift
//  Helpet
//
//  Created by Efim Nikitin on 14.06.2023.
//

import SwiftUI

struct NavigationLinkModifier: ViewModifier {
    func body(content: Content) -> some View {
        HStack {
            content

            Spacer()

            Image(systemName: "chevron.right")
                .font(.system(size: 10).weight(.bold))
                .foregroundColor(.Foreground.primary.opacity(0.3))
        }
    }
}

extension View {
    func navigationLink() -> some View {
        modifier(NavigationLinkModifier())
    }
}
