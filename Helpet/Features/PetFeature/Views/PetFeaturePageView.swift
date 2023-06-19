//
//  PetFeaturePageView.swift
//  Helpet
//
//  Created by Efim Nikitin on 17.06.2023.
//

import SwiftUI

struct PetFeaturePageView: View {
    private let localizedConstants = LocalizedConstants()

    @StateObject private var viewModel: PetFeaturePageViewModel

    @EnvironmentObject private var petViewModel: PetProfilePageViewModel

    @Environment(\.dismiss) private var dismiss

    let petFeature: PetFeature

    init(petFeature: PetFeature, pet: Pet) {
        self.petFeature = petFeature
        self._viewModel = StateObject(wrappedValue: PetFeaturePageViewModel(pet: pet))
    }

    var body: some View {
        DismissSheet(title: localizedConstants.title, presentationDetents: [.medium]) {
            InfoRowView(label: petFeature.name, content: petFeature.description)
                .padding()
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        DeleteButtonView {
                            if await viewModel.deletePetFeature(petFeature) {
                                petViewModel.petFeatures.removeAll(where: { $0.id == petFeature.id })
                                dismiss()
                            }
                        }
                    }
                }
        }
        .requestStatus(viewModel.requestStatus)
    }
}

extension PetFeaturePageView {
    private struct LocalizedConstants {
        let title = Localizer.l10n(key: "PET_FEATURE_PAGE_VIEW.TITLE")
    }
}
