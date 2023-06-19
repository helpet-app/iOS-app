//
//  VaccinationPageView.swift
//  Helpet
//
//  Created by Efim Nikitin on 17.06.2023.
//

import SwiftUI

struct VaccinationPageView: View {
    private let localizedConstants = LocalizedConstants()

    @StateObject private var viewModel: VaccinationPageViewModel

    @EnvironmentObject private var petViewModel: PetProfilePageViewModel

    @Environment(\.dismiss) private var dismiss

    let vaccination: PetVaccination

    init(vaccination: PetVaccination, pet: Pet) {
        self.vaccination = vaccination
        self._viewModel = StateObject(wrappedValue: VaccinationPageViewModel(pet: pet))
    }

    var name: some View {
        InfoRowView(label: localizedConstants.nameLabel, content: vaccination.vaccinationName)
    }

    var comment: some View {
        InfoRowView(label: localizedConstants.commentLabel, content: vaccination.comment)
    }

    var dateOfVaccination: some View {
        InfoRowView(label: localizedConstants.dateOfVaccinationLabel, content: vaccination.vaccinatedOn.formatted(.dateTime.day().month(.wide).year()))
    }

    var body: some View {
        DismissSheet(title: localizedConstants.title) {
            VStack(spacing: DefaultViewConstants.Spacing.large) {
                name

                comment

                dateOfVaccination
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    DeleteButtonView {
                        if await viewModel.deletePetVaccination(vaccination) {
                            petViewModel.vaccinationHistory.removeAll(where: { $0.id == vaccination.id })
                            dismiss()
                        }
                    }
                }
            }
        }
        .requestStatus(viewModel.requestStatus)
    }
}

extension VaccinationPageView {
    private struct LocalizedConstants {
        let title = Localizer.l10n(key: "PET_VACCINATION_PAGE_VIEW.TITLE")

        let nameLabel = Localizer.l10n(key: "PET_VACCINATION_PAGE_VIEW.NAME_LABEL")

        let commentLabel = Localizer.l10n(key: "PET_VACCINATION_PAGE_VIEW.COMMENT_LABEL")

        let dateOfVaccinationLabel = Localizer.l10n(key: "PET_VACCINATION_PAGE_VIEW.DATE_OF_VACCINATION_LABEL")
    }
}
