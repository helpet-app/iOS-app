//
//  LabelModifier.swift
//  Helpet
//
//  Created by Efim Nikitin on 23.01.2023.
//

import SwiftUI

struct LabelModifier: ViewModifier {
    let label: String

    func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label)
                .font(.caption.weight(.semibold))
                .textCase(.uppercase)
                .foregroundColor(.Foreground.quinary)
                .padding(.horizontal)

            content
        }
    }
}

extension View {
    func label(_ label: String) -> some View {
        modifier(LabelModifier(label: label))
    }
}
