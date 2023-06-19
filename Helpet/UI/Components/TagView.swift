//
//  TagView.swift
//  Helpet
//
//  Created by Efim Nikitin on 18.01.2023.
//

import SwiftUI

struct TagView: View {
    let caption: String

    var body: some View {
        Text(caption)
            .font(.caption.weight(.medium))
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .foregroundColor(.Foreground.tertiary)
            .background(Color.Background.tertiary)
            .clipShape(Capsule(style: .continuous))
    }
}

struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        TagView(caption: "Health")
    }
}
