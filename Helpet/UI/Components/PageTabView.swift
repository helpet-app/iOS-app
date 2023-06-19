//
//  PageTabView.swift
//  Helpet
//
//  Created by Efim Nikitin on 01.02.2023.
//

import SwiftUI

struct PageTabView<Content: View, ViewModel: TabViewModel>: View {
    @Namespace private var namespace

    @ObservedObject var viewModel: ViewModel

    @ViewBuilder let tab: (ViewModel.TabType) -> Content

    @ViewBuilder
    func tabItem(for tab: (label: String, type: ViewModel.TabType)) -> some View {
        Button {
            viewModel.switchTab(to: tab.type)
        } label: {
            ZStack {
                if viewModel.selectedTab == tab.type {
                    Capsule(style: .continuous)
                        .foregroundColor(.Background.tertiary)
                        .matchedGeometryEffect(id: "ClipShape", in: namespace, properties: .frame)
                }

                Text(tab.label)
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(viewModel.selectedTab == tab.type ? .Foreground.tertiary : .Foreground.quinary)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
            }
            .animation(.easeInOut(duration: 0.25), value: viewModel.selectedTab)
        }
        .buttonStyle(.plain)
    }

    var tabs: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { proxy in
                HStack(spacing: DefaultViewConstants.Spacing.extraLarge) {
                    ForEach(viewModel.tabs, id: \.type) { tab in
                        tabItem(for: tab)
                            .id(tab.type)
                    }
                }
                .padding(DefaultViewConstants.Padding.extraSmall)
                .onChange(of: viewModel.selectedTab) { newValue in
                    withAnimation {
                        proxy.scrollTo(newValue, anchor: .bottom)
                    }
                }
                .background(Color.Background.secondary)
                .clipShape(Capsule(style: .continuous))
            }
        }
    }

    var body: some View {
        VStack(spacing: DefaultViewConstants.Spacing.medium) {
            tabs

            tab(viewModel.selectedTab)
                .frame(minHeight: UIScreen.mainBounds?.height * 0.5)
        }
    }
}
