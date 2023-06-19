//
//  CardView.swift
//  Helpet
//
//  Created by Efim Nikitin on 20.01.2023.
//

import SwiftUI

struct CardView<Content: View>: View {
    let showDividers: Bool

    let content: Content

    init(showDividers: Bool = true, @ViewBuilder content: () -> Content) {
        self.showDividers = showDividers
        self.content = content()
    }

    var body: some View {
        Subviews(of: content) { views in
            VStack(spacing: 0) {
                ForEach(views) { view in
                    view
                        .padding()

                    if showDividers && view.id != views.last?.id {
                        Divider()
                    }
                }
            }
        }
        .background(Color.Background.secondary)
        .rounded()
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView {
            CardRowView(image: Image(systemName: "house"), name: "Дом", value: "Новосибирск")
            CardRowView(image: Image(systemName: "house"), name: "Дом", value: "Новосибирск")
            CardRowView(image: Image(systemName: "house"), name: "Дом", value: "Новосибирск")
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.Background.primary)
    }
}
