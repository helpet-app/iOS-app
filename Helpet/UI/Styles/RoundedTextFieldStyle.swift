//
//  RoundedTextFieldStyle.swift
//  Helpet
//
//  Created by Efim Nikitin on 17.01.2023.
//

import SwiftUI

struct RoundedTextFieldStyle: TextFieldStyle {
    @FocusState private var textFieldFocused: Bool

    func _body(configuration: TextField<Self._Label>) -> some View {
        return configuration
            .padding()
            .background(Color.Background.tertiary)
            .font(.subheadline)
            .rounded()
            .focused($textFieldFocused)
            .onTapGesture {
                textFieldFocused = true
            }
    }
}
