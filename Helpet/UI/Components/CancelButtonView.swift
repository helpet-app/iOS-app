//
//  CancelButtonView.swift
//  Helpet
//
//  Created by Efim Nikitin on 10.02.2023.
//

import SwiftUI

struct CancelButtonView: View {
    let onTap: () async -> Void

    var body: some View {
        Button {
            Task {
                await onTap()
            }
        } label: {
            Text(Localizer.l10n(key: "CANCEL_BUTTON_LABEL"))
                .padding([.vertical, .trailing])
        }
        .buttonStyle(DefaultButtonStyle())
    }
}

struct CancelButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CancelButtonView {

        }
    }
}
