//
//  ListView.swift
//  Helpet
//
//  Created by Efim Nikitin on 26.01.2023.
//

import SwiftUI

struct ListView<Item: Identifiable, Row: View, Destination: View>: View {
    @State private var selectedItem: Item?

    let items: [Item]

    let style: Style

    @ViewBuilder let row: (Item) -> Row

    @ViewBuilder let destination: (Item) -> Destination

    init(items: [Item], style: Style = .sheet, row: @escaping (Item) -> Row, destination: @escaping (Item) -> Destination) {
        self.items = items
        self.style = style
        self.row = row
        self.destination = destination
    }

    @ViewBuilder
    func rowView(for item: Item) -> some View {
        switch style {
        case .link:
            NavigationLink {
                destination(item)
            } label: {
                row(item)
                    .modifier(NavigationLinkModifier())
                    .padding()
            }
            .buttonStyle(NavigationLinkStyle())
            .rounded()
        case .sheet:
            Button {
                selectedItem = item
            } label: {
                row(item)
                    .padding()
                    .background(Color.Background.secondary)
                    .rounded()
            }
            .sheet(item: $selectedItem) { item in
                destination(item)
            }
            .buttonStyle(ScaledButtonStyle())
        }
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: DefaultViewConstants.Spacing.medium) {
                if items.isEmpty {
                    EmptyListView()
                } else {
                    ForEach(items) { item in
                        rowView(for: item)
                    }
                }
            }
            .padding(.bottom)
            .frame(maxWidth: .infinity)
        }
        .background(Color.Background.primary)
    }
}

extension ListView {
    enum Style {
        case link
        case sheet
    }
}
