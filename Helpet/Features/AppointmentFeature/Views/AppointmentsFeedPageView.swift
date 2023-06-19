//
//  AppointmentsFeedPageView.swift
//  Helpet
//
//  Created by Efim Nikitin on 02.02.2023.
//

import SwiftUI

struct AppointmentsFeedPageView: View {
    @StateObject private var viewModel = AppointmentsFeedPageViewModel()

    @State private var selectedAppointment: Appointment?

    var body: some View {
        VStack {
            FeedView(itemsGroupedByDate: viewModel.appointmentsGroupedByDate) { appointment in
                Button {
                    selectedAppointment = appointment
                } label: {
                    AppointmentListRowView(appointment: appointment)
                        .padding()
                        .background(Color.Background.secondary)
                        .rounded()
                }
                .sheet(item: $selectedAppointment) { appointment in
                    AppointmentPageView(appointment: appointment)
                }
                .buttonStyle(ScaledButtonStyle())
            }
            .refreshable {
                await viewModel.fetchAppointments()
            }
            .fetchStatus(viewModel.requestStatus) {
                await viewModel.fetchAppointments()
            }
        }
        .background(Color.Background.primary)
        .animation(.default, value: viewModel.appointmentsGroupedByDate.count)
    }
}

struct AppointmentsFeedPageView_Previews: PreviewProvider {
    static var previews: some View {
        AppointmentsFeedPageView()
    }
}
