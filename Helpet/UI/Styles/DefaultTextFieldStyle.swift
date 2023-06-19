//
//  DefaultTextFieldStyle.swift
//  Helpet
//
//  Created by Efim Nikitin on 17.01.2023.
//

import SwiftUI

struct DefaultTextFieldStyle: TextFieldStyle {
    @FocusState private var textFieldFocused: Bool

    func _body(configuration: TextField<Self._Label>) -> some View {
        return configuration
            .padding()
            .background(Color.Background.tertiary)
            .font(.subheadline)
            .focused($textFieldFocused)
            .onTapGesture {
                textFieldFocused = true
            }
    }
}
