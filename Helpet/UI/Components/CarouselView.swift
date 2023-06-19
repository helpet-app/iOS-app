//
//  CarouselView.swift
//  Helpet
//
//  Created by Efim Nikitin on 24.01.2023.
//

import SwiftUI

struct CarouselView<Content: View, ViewModel: TabViewModel>: View {
    @Namespace private var namespace

    @ObservedObject var viewModel: ViewModel

    @ViewBuilder let content: Content

    @ViewBuilder
    func tabItem(for tab: (label: String, type: ViewModel.TabType)) -> some View {
        Button {
            withAnimation {
                viewModel.switchTab(to: tab.type)
            }
        } label: {
            VStack(spacing: 6) {
                Text(tab.label)
                    .font(.body.weight(.semibold))
                    .foregroundColor(viewModel.selectedTab == tab.type ? .Foreground.primary : .Foreground.quinary)

                let underline = Capsule().frame(height: 2)

                if viewModel.selectedTab == tab.type {
                    underline
                        .matchedGeometryEffect(id: "Underline", in: namespace, properties: .frame)
                } else {
                    underline
                        .hidden()
                }
            }
            .animation(.easeInOut(duration: 0.25), value: viewModel.selectedTab)
        }
        .buttonStyle(DefaultButtonStyle())
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
                .padding(.horizontal)
                .padding(.top, DefaultViewConstants.Padding.small)
                .onChange(of: viewModel.selectedTab) { newValue in
                    withAnimation {
                        proxy.scrollTo(newValue, anchor: .center)
                    }
                }
            }
        }
    }

    var body: some View {
        VStack(spacing: DefaultViewConstants.Spacing.medium) {
            tabs

            TabView(selection: $viewModel.selectedTab) {
                content
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
    }
}
