//
//  DeleteButtonView.swift
//  Helpet
//
//  Created by Efim Nikitin on 17.06.2023.
//

import SwiftUI

struct DeleteButtonView: View {
    @State private var alertIsPresented = false

    let onTap: () async -> Void

    var body: some View {
        Button {
            alertIsPresented = true
        } label: {
            Image(systemName: "trash")
                .font(.footnote.weight(.bold))
        }
        .alert(Localizer.l10n(key: "DELETE_BUTTON_VIEW.MESSAGE"), isPresented: $alertIsPresented) {
            Button(Localizer.l10n(key: "DELETE_BUTTON_VIEW.CONFIRM_MESSAGE"), role: .destructive) {
                Task {
                    await onTap()
                }
            }
        }
    }
}

struct DeleteButtonView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteButtonView {

        }
    }
}
