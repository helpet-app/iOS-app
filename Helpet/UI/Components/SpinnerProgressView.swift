//
//  SpinnerProgressView.swift
//  Helpet
//
//  Created by Efim Nikitin on 09.05.2023.
//

import SwiftUI

struct SpinnerProgressView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: DefaultViewConstants.CornerRadius.large, style: .continuous)
                .foregroundColor(.Background.secondary)
                .frame(width: 80, height: 80)
                .shadow(radius: 50)

            ProgressView()
                .progressViewStyle(SpinnerProgressViewStyle())
        }
    }
}

struct SpinnerProgressView_Previews: PreviewProvider {
    static var previews: some View {
        SpinnerProgressView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.Background.primary)
    }
}
