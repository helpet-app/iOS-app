//
//  DiseasePageView.swift
//  Helpet
//
//  Created by Efim Nikitin on 17.06.2023.
//

import SwiftUI

struct DiseasePageView: View {
    private let localizedConstants = LocalizedConstants()

    @StateObject private var viewModel: DiseasePageViewModel

    @EnvironmentObject private var petViewModel: PetProfilePageViewModel

    @Environment(\.dismiss) private var dismiss

    let disease: PetDisease

    init(disease: PetDisease, pet: Pet) {
        self.disease = disease
        self._viewModel = StateObject(wrappedValue: DiseasePageViewModel(pet: pet))
    }

    var name: some View {
        InfoRowView(label: localizedConstants.nameLabel, content: disease.diseaseName)
    }

    var comment: some View {
        InfoRowView(label: localizedConstants.commentLabel, content: disease.comment)
    }

    var dateOfIllness: some View {
        InfoRowView(label: localizedConstants.dateOfIllnessLabel, content: disease.gotSickOn.formatted(.dateTime.day().month(.wide).year()))
    }

    var dateOfRecovery: some View {
        InfoRowView(label: localizedConstants.dateOfRecoveryLabel, content: disease.recoveredOn?.formatted(.dateTime.day().month(.wide).year()))
    }

    var body: some View {
        DismissSheet(title: localizedConstants.title) {
            VStack(spacing: DefaultViewConstants.Spacing.large) {
                name

                comment

                dateOfIllness

                dateOfRecovery
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    DeleteButtonView {
                        if await viewModel.deletePetDisease(disease) {
                            petViewModel.diseaseHistory.removeAll(where: { $0.id == disease.id })
                            dismiss()
                        }
                    }
                }
            }
        }
        .requestStatus(viewModel.requestStatus)
    }
}

extension DiseasePageView {
    private struct LocalizedConstants {
        let title = Localizer.l10n(key: "PET_DISEASE_PAGE_VIEW.TITLE")

        let nameLabel = Localizer.l10n(key: "PET_DISEASE_PAGE_VIEW.NAME_LABEL")

        let commentLabel = Localizer.l10n(key: "PET_DISEASE_PAGE_VIEW.COMMENT_LABEL")

        let dateOfIllnessLabel = Localizer.l10n(key: "PET_DISEASE_PAGE_VIEW.DATE_OF_ILLNESS_LABEL")

        let dateOfRecoveryLabel = Localizer.l10n(key: "PET_DISEASE_PAGE_VIEW.DATE_OF_RECOVERY_LABEL")
    }
}
