//
//  PetProfilePageView.swift
//  Helpet
//
//  Created by Efim Nikitin on 26.01.2023.
//

import SwiftUI

struct PetProfilePageView: View {
    private let localizedConstants = LocalizedConstants()

    @StateObject private var viewModel: PetProfilePageViewModel

    @StateObject private var pageTabViewModel = PetProfileTabViewModel()

    @StateObject private var sheetMenuViewModel = PetProfilePageSheetMenuViewModel()

    @EnvironmentObject private var familyPageViewModel: FamilyPageViewModel

    @Environment(\.presentationMode) private var presentationMode

    init(pet: Pet) {
        self._viewModel = StateObject(wrappedValue: PetProfilePageViewModel(pet: pet))
    }

    var profileImage: some View {
        Image(systemName: "pawprint.circle.fill")
            .font(.system(size: 100))
    }

    var name: some View {
        Text(viewModel.pet.name)
            .font(.title3)
            .fontWeight(.semibold)
    }

    var basicMedicalCardInfo: some View {
        CardView {
            if let petCategory = viewModel.extractPetCategory() {
                CardRowView(image: Image(systemName: "pawprint.fill"),
                            name: localizedConstants.speciesLabel,
                            value: petCategory)
            }

            if let dateOfBirth = viewModel.petMedicalCard?.dateOfBirth {
                CardRowView(image: Image(systemName: "calendar"),
                            name: localizedConstants.dateOfBirthLabel,
                            value: dateOfBirth.formatted(.dateTime.day().month().year()))
            }

            if let gender = viewModel.petMedicalCard?.gender {
                CardRowView(image: Image(systemName: "g.square"),
                            name: localizedConstants.genderLabel,
                            value: gender.name)
            }

            if let isSpayedOrNeutered = viewModel.petMedicalCard?.isSpayedOrNeutered {
                CardRowView(image: Image(systemName: "heart.text.square"),
                            name: localizedConstants.sterilizationLabel,
                            value: isSpayedOrNeutered ? localizedConstants.sterilizedLabel : localizedConstants.unsterilizedLabel)
            }

            if let chipNumber = viewModel.petMedicalCard?.chipNumber {
                CardRowView(image: Image(systemName: "number.square"),
                            name: localizedConstants.chipNumberLabel,
                            value: chipNumber)
            }

            Group {
                if case .loading = viewModel.medicalCardRequestStatus {
                    ProgressView()
                } else if case .failure = viewModel.medicalCardRequestStatus {
                    Button {
                        Task {
                            await viewModel.fetchPetMedicalCard()
                        }
                    } label: {
                        Image(systemName: "arrow.counterclockwise")
                            .font(.title3.weight(.semibold))
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
        .task {
            await viewModel.fetchPetMedicalCard()
        }
    }

    var appointmentList: some View {
        ListView(items: viewModel.appointmentHistory.sorted(by: \.scheduledAt, using: >)) { appointment in
            AppointmentListRowView(appointment: appointment)
        } destination: { appointment in
            AppointmentPageView(appointment: appointment)
        }
        .fetchStatus(viewModel.tabsRequestStatuses[.appointmentHistory], alignment: .top) {
            await viewModel.fetchPetAppointmentHistory()
        }
        .task {
            await viewModel.fetchPetAppointmentHistory()
        }
    }

    var petFeatureList: some View {
        ListView(items: viewModel.petFeatures.sorted(by: \.createdAt, using: >)) { petFeature in
            PetFeatureListRowView(petFeature: petFeature)
        } destination: { petFeature in
            PetFeaturePageView(petFeature: petFeature, pet: viewModel.pet)
                .environmentObject(viewModel)
        }
        .fetchStatus(viewModel.tabsRequestStatuses[.petFeatures], alignment: .top) {
            await viewModel.fetchPetFeatures()
        }
        .task {
            await viewModel.fetchPetFeatures()
        }
    }

    var diseaseList: some View {
        ListView(items: viewModel.diseaseHistory.sorted(by: \.gotSickOn, using: >)) { disease in
            DiseaseListRowView(disease: disease)
        } destination: { disease in
            DiseasePageView(disease: disease, pet: viewModel.pet)
                .environmentObject(viewModel)
        }
        .fetchStatus(viewModel.tabsRequestStatuses[.diseaseHistory], alignment: .top) {
            await viewModel.fetchPetDiseaseHistory()
        }
        .task {
            await viewModel.fetchPetDiseaseHistory()
        }
    }

    var antropometryList: some View {
        ListView(items: viewModel.antropometryHistory.sorted(by: \.createdAt, using: >)) { anthropometry in
            AnthropometryListRowView(anthropometry: anthropometry)
        } destination: { anthropometry in
            AnthropometryPageView(anthropometry: anthropometry, pet: viewModel.pet)
                .environmentObject(viewModel)
        }
        .fetchStatus(viewModel.tabsRequestStatuses[.antropometryHistory], alignment: .top) {
            await viewModel.fetchPetAntropometryHistory()
        }
        .task {
            await viewModel.fetchPetAntropometryHistory()
        }
    }

    var vaccinationList: some View {
        ListView(items: viewModel.vaccinationHistory.sorted(by: \.vaccinatedOn, using: >)) { vaccination in
            VaccinationListRowView(vaccination: vaccination)
        } destination: { vaccination in
            VaccinationPageView(vaccination: vaccination, pet: viewModel.pet)
                .environmentObject(viewModel)
        }
        .fetchStatus(viewModel.tabsRequestStatuses[.vaccinationHistory], alignment: .top) {
            await viewModel.fetchPetVaccinationHistory()
        }
        .task {
            await viewModel.fetchPetVaccinationHistory()
        }
    }

    var additionalMedicalCardInfo: some View {
        PageTabView(viewModel: pageTabViewModel) { tabType in
            switch tabType {
            case .appointmentHistory: appointmentList
            case .petFeatures: petFeatureList
            case .diseaseHistory: diseaseList
            case .antropometryHistory: antropometryList
            case .vaccinationHistory: vaccinationList
            }
        }
    }

    var deleteButton: some View {
        DeleteButtonView {
            if await viewModel.deletePet() {
                familyPageViewModel.pets.removeAll(where: { $0.id == viewModel.pet.id })
                presentationMode.wrappedValue.dismiss()
            }
        }
    }

    var addButton: some View {
        SheetMenuView(viewModel: sheetMenuViewModel) { sheetType in
            switch sheetType {
            case .addPetFeature: CreatePetFeaturePageView(pet: viewModel.pet).environmentObject(viewModel)
            case .addDisease: CreateDiseasePageView(pet: viewModel.pet).environmentObject(viewModel)
            case .addAnthropometry: CreateAnthropometryPageView(pet: viewModel.pet).environmentObject(viewModel)
            case .addVaccination: CreateVaccinationPageView(pet: viewModel.pet).environmentObject(viewModel)
            }
        }
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: DefaultViewConstants.Spacing.medium) {
                profileImage

                name

                basicMedicalCardInfo

                additionalMedicalCardInfo
            }
            .padding(.horizontal)
        }
        .requestStatus(viewModel.deleteRequestStatus)
        .foregroundColor(.Foreground.primary)
        .background(Color.Background.primary.ignoresSafeArea(.all))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                deleteButton
            }

            ToolbarItem(placement: .navigationBarTrailing) {
                addButton
            }
        }
    }
}

extension PetProfilePageView {
    private struct LocalizedConstants {
        let categoryLabel = Localizer.l10n(key: "PET_PROFILE_PAGE.CATEGORY_LABEL")

        let speciesLabel = Localizer.l10n(key: "PET_PROFILE_PAGE.SPECIES_LABEL")

        let dateOfBirthLabel = Localizer.l10n(key: "PET_PROFILE_PAGE.DATE_OF_BIRTH_LABEL")

        let genderLabel = Localizer.l10n(key: "PET_PROFILE_PAGE.GENDER_LABEL")

        let sterilizationLabel = Localizer.l10n(key: "PET_PROFILE_PAGE.STERILIZATION_LABEL")

        let sterilizedLabel = Localizer.l10n(key: "PET_PROFILE_PAGE.STERILIZED_LABEL")

        let unsterilizedLabel = Localizer.l10n(key: "PET_PROFILE_PAGE.UNSTERILIZED_LABEL")

        let chipNumberLabel = Localizer.l10n(key: "PET_PROFILE_PAGE.CHIP_NUMBER_LABEL")
    }
}
