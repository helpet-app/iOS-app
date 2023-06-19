//
//  NotImplementedYetView.swift
//  Helpet
//
//  Created by Efim Nikitin on 14.06.2023.
//

import SwiftUI

struct NotImplementedYetView: View {
    var body: some View {
        VStack(spacing: DefaultViewConstants.Spacing.medium) {
            Image(systemName: "bird.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 80)
                .foregroundColor(.Foreground.primary)

            Text(Localizer.l10n(key: "NOT_IMPLEMENTED_YET_VIEW.TITLE"))
                .font(.title3.weight(.bold))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.Background.primary)
    }
}

struct NotImplementedYetView_Previews: PreviewProvider {
    static var previews: some View {
        NotImplementedYetView()
    }
}
