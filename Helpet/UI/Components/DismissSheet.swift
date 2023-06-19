//
//  DismissSheet.swift
//  Helpet
//
//  Created by Efim Nikitin on 17.06.2023.
//

import SwiftUI

struct DismissSheet<Content: View>: View {
    let title: String

    let presentationDetents: Set<PresentationDetent>

    let content: Content

    init(title: String, presentationDetents: Set<PresentationDetent> = [.large], @ViewBuilder content: () -> Content) {
        self.title = title
        self.presentationDetents = presentationDetents
        self.content = content()
    }

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                content
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    DismissButtonView()
                }
            }
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.Background.primary)
            .foregroundColor(.Foreground.primary)
        }
        .presentationDetents(presentationDetents)
        .presentationDragIndicator(.hidden)
    }
}

struct DismissSheet_Previews: PreviewProvider {
    static var previews: some View {
        DismissSheet(title: "Title") {

        }
    }
}
