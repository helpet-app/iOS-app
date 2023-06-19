//
//  TimeSlotPickerView.swift
//  Helpet
//
//  Created by Efim Nikitin on 18.06.2023.
//

import SwiftUI

struct TimeSlotPickerView: View {
    private let localizedConstants = LocalizedConstants()

    @StateObject private var viewModel: TimeSlotPickerViewModel

    @ObservedObject private var createAppointmentPageViewModel: CreateAppointmentPageViewModel

    init(createAppointmentPageViewModel: CreateAppointmentPageViewModel) {
        self._viewModel = StateObject(wrappedValue: TimeSlotPickerViewModel(vet: createAppointmentPageViewModel.vet,
                                                                            date: createAppointmentPageViewModel.createAppointmentInfo.date))
        self.createAppointmentPageViewModel = createAppointmentPageViewModel
    }

    var body: some View {
        PickerPageView(label: localizedConstants.pickerLabel,
                       selectedItem: $createAppointmentPageViewModel.createAppointmentInfo.timeSlot,
                       viewModel: viewModel) { timeSlot in
            dateRow(for: timeSlot)
        } itemRowView: { timeSlot in
            dateRow(for: timeSlot)
        }
        .onChange(of: createAppointmentPageViewModel.createAppointmentInfo.date) { newDate in
            self.viewModel.date = newDate
            self.viewModel.requestStatus = nil
            self.createAppointmentPageViewModel.createAppointmentInfo.timeSlot = nil
        }
    }

    @ViewBuilder
    private func dateRow(for timeSlot: TimeSlot) -> some View {
        Text(timeSlot.startTime.formatted(.dateTime.hour().minute()))
    }
}

extension TimeSlotPickerView {
    private struct LocalizedConstants {
        let pickerLabel = Localizer.l10n(key: "TIME_SLOT_PICKER.PICKER_LABEL")
    }
}
