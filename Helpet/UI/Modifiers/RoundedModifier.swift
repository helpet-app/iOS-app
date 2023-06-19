//
//  RoundedModifier.swift
//  Helpet
//
//  Created by Efim Nikitin on 14.06.2023.
//

import SwiftUI

struct RoundedModifier: ViewModifier {
    let cornerRadius: CGFloat

    func body(content: Content) -> some View {
        content
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
    }
}

extension View {
    func rounded(cornerRadius: CGFloat = DefaultViewConstants.CornerRadius.medium) -> some View {
        modifier(RoundedModifier(cornerRadius: cornerRadius))
    }
}
