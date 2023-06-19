//
//  DismissButtonView.swift
//  Helpet
//
//  Created by Efim Nikitin on 09.02.2023.
//

import SwiftUI

struct DismissButtonView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "multiply")
                .font(.body.weight(.bold))
        }
    }
}

struct DismissButtonView_Previews: PreviewProvider {
    static var previews: some View {
        DismissButtonView()
    }
}
