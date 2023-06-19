//
//  EmptyListView.swift
//  Helpet
//
//  Created by Efim Nikitin on 14.06.2023.
//

import SwiftUI

struct EmptyListView: View {
    var body: some View {
        VStack(spacing: DefaultViewConstants.Spacing.medium) {
            Image(systemName: "smoke")
                .resizable()
                .scaledToFit()
                .frame(width: 50)

            Text(Localizer.l10n(key: "LIST_COMPONENT.EMPTY_LIST_LABEL"))
                .font(.subheadline.weight(.semibold))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .foregroundColor(.Foreground.quinary)
        .padding()
    }
}

struct EmptyListView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyListView()
    }
}
