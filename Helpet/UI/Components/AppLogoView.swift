//
//  AppLogoView.swift
//  Helpet
//
//  Created by Efim Nikitin on 17.01.2023.
//

import SwiftUI

struct AppLogoView: View {
    var body: some View {
        Image(systemName: "pawprint.fill")
            .frame(width: 80, height: 80)
            .font(.system(size: 36))
            .foregroundColor(.Background.primary)
            .background(Color.Foreground.primary)
            .rounded(cornerRadius: DefaultViewConstants.CornerRadius.large)
    }
}

struct AppLogoView_Previews: PreviewProvider {
    static var previews: some View {
        AppLogoView()
    }
}
