//
//  VetsFeedPageView.swift
//  Helpet
//
//  Created by Efim Nikitin on 09.02.2023.
//

import SwiftUI

struct VetsFeedPageView: View {
    @StateObject private var viewModel = VetsFeedPageViewModel()

    @State private var selectedVet: Vet?

    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: DefaultViewConstants.Spacing.medium) {
                    ForEach(viewModel.vets) { vet in
                        Button {
                            selectedVet = vet
                        } label: {
                            FeedCardView(imageUrl: vet.avatarUrl,
                                         tags: vet.tags.map(\.name),
                                         headline: vet.name,
                                         subheadline: vet.bio)
                        }
                        .sheet(item: $selectedVet) { vet in
                            VetProfilePageView(vet: vet)
                        }
                        .buttonStyle(ScaledButtonStyle())
                    }
                }
                .padding()
            }
            .refreshable {
                await viewModel.fetchVets()
            }
            .fetchStatus(viewModel.requestStatus) {
                await viewModel.fetchVets()
            }
        }
        .background(Color.Background.primary)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {

                } label: {
                    Image(systemName: "line.3.horizontal.decrease.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                }
            }
        }
        .animation(.default, value: viewModel.vets.isEmpty)
    }
}

struct VetsFeedPageView_Previews: PreviewProvider {
    static var previews: some View {
        VetsFeedPageView()
    }
}
