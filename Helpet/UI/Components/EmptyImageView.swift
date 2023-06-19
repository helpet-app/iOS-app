//
//  EmptyImageView.swift
//  Helpet
//
//  Created by Efim Nikitin on 07.05.2023.
//

import SwiftUI

struct EmptyImageView: View {
    var body: some View {
        Image(systemName: "questionmark.app.dashed")
            .font(.system(size: 48))
            .foregroundColor(.Foreground.quinary)
    }
}

struct EmptyImageView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyImageView()
    }
}
