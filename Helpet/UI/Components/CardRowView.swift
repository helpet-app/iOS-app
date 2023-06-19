//
//  CardRowView.swift
//  Helpet
//
//  Created by Efim Nikitin on 20.01.2023.
//

import SwiftUI

struct CardRowView: View {
    let image: Image

    let name: String

    let value: String

    var body: some View {
        HStack {
            image
                .font(.system(size: 16))
                .frame(width: 32)

            Text(name)

            Spacer()

            Text(value)
        }
        .lineLimit(1)
        .font(.subheadline)
    }
}

struct CardRowView_Previews: PreviewProvider {
    static var previews: some View {
        CardRowView(image: Image(systemName: "house"), name: "Дом", value: "Новосибирск")
    }
}
