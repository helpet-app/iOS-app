//
//  AppointmentsFeedPageViewModel.swift
//  Helpet
//
//  Created by Efim Nikitin on 02.02.2023.
//

import Foundation

final class AppointmentsFeedPageViewModel: ObservableObject {
    private let appointmentService = AppointmentService()

    private var pageParams = PageParams()

    @Published private(set) var appointmentsGroupedByDate: [(key: Date, value: [Appointment])] = []

    @Published private(set) var requestStatus: RequestStatus?

    init() {
        self.requestStatus = .loading

        Task {
            await fetchAppointments()
        }
    }

    @MainActor
    func fetchAppointments() async {
        do {
            let appointments = try await appointmentService.getAppointments(pageParams: PageParams()).content

            self.appointmentsGroupedByDate = appointments.groupedBy(dateComponents: [.day, .month, .year], key: \.scheduledAt).sorted { $0.key > $1.key }

            self.requestStatus = .success
        } catch {
            self.requestStatus = .failure(error: error)
        }
    }
}
