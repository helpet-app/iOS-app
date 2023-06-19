//
//  CreateAppointmentPageView.swift
//  Helpet
//
//  Created by Efim Nikitin on 18.06.2023.
//

import SwiftUI

struct CreateAppointmentPageView: View {
    private let localizedConstants = LocalizedConstants()

    @StateObject private var viewModel: CreateAppointmentPageViewModel

    @Environment(\.dismiss) private var dismiss

    init(vet: Vet) {
        self._viewModel = StateObject(wrappedValue: CreateAppointmentPageViewModel(vet: vet))
    }

    var problemTextField: some View {
        TextField(localizedConstants.problemFieldPlaceholder, text: $viewModel.createAppointmentInfo.problem, axis: .vertical)
            .label(localizedConstants.problemFieldLabel)
    }

    var petPicker: some View {
        PetPickerView(selectedPet: $viewModel.createAppointmentInfo.pet)
            .label(localizedConstants.petPickerLabel)
    }

    var datePicker: some View {
        DatePicker(localizedConstants.datePickerLabel,
                   selection: $viewModel.createAppointmentInfo.date,
                   in: Calendar.current.date(byAdding: .day, value: 1, to: Date())!...,
                   displayedComponents: [.date])
            .font(.subheadline)
            .padding()
            .background(Color.Background.tertiary)
            .rounded()
            .label(localizedConstants.datePickerLabel)
    }

    var timeSlotPicker: some View {
        TimeSlotPickerView(createAppointmentPageViewModel: viewModel)
            .label(localizedConstants.timeSlotPickerLabel)
    }

    @ViewBuilder
    private func dateRow(for timeSlot: TimeSlot) -> some View {
        Text(timeSlot.startTime.formatted(.dateTime.hour().minute()))
    }

    var body: some View {
        CancelDonePageView(title: localizedConstants.title, doneButtonIsEnabled: viewModel.formIsFilled) {
            VStack(spacing: DefaultViewConstants.Spacing.large) {
                problemTextField

                petPicker

                datePicker

                timeSlotPicker
            }
        } onDoneTap: {
            if await viewModel.createAppointment() {
                dismiss()
            }
        }
        .requestStatus(viewModel.requestStatus)
    }
}

extension CreateAppointmentPageView {
    private struct LocalizedConstants {
        let title = Localizer.l10n(key: "VET_PROFILE_PAGE.NEW_APPOINTMENT.TITLE")

        let problemFieldLabel = Localizer.l10n(key: "VET_PROFILE_PAGE.NEW_APPOINTMENT.PROBLEM_FIELD_LABEL")

        let problemFieldPlaceholder = Localizer.l10n(key: "VET_PROFILE_PAGE.NEW_APPOINTMENT.PROBLEM_FIELD_PLACEHOLDER")

        let petPickerLabel = Localizer.l10n(key: "VET_PROFILE_PAGE.NEW_APPOINTMENT.PET_PICKER_LABEL")

        let datePickerLabel = Localizer.l10n(key: "VET_PROFILE_PAGE.NEW_APPOINTMENT.DATE_PICKER_LABEL")

        let timeSlotPickerLabel = Localizer.l10n(key: "VET_PROFILE_PAGE.NEW_APPOINTMENT.TIME_SLOT_PICKER_LABEL")
    }
}
