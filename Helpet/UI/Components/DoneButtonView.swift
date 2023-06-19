//
//  DoneButtonView.swift
//  Helpet
//
//  Created by Efim Nikitin on 10.02.2023.
//

import SwiftUI

struct DoneButtonView: View {
    let isEnabled: Bool

    let onTap: () async -> Void

    var body: some View {
        Button {
            Task {
                await onTap()
            }
        } label: {
            Text(Localizer.l10n(key: "DONE_BUTTON_LABEL"))
                .font(.body.weight(.semibold))
                .padding([.vertical, .leading])
        }
        .buttonStyle(DefaultButtonStyle(isEnabled: isEnabled))
        .disabled(!isEnabled)
    }
}

struct DoneButtonView_Previews: PreviewProvider {
    static var previews: some View {
        DoneButtonView(isEnabled: false) {

        }
    }
}
