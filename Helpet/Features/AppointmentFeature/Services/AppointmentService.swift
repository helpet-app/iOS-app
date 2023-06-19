//
//  AppointmentService.swift
//  Helpet
//
//  Created by Efim Nikitin on 31.05.2023.
//

import Foundation

final class AppointmentService {
    private let apiClient = APIClient(baseURL: APIConfig.Service.appointmentServiceURL)

    func getAppointments(pageParams: PageParams) async throws -> PageResponse<Appointment> {
        return try await apiClient.dispatch(GetAppointmentsRequest(pageParams: pageParams))
    }

    func getAppointment(id: UUID) async throws -> Appointment {
        return try await apiClient.dispatch(GetAppointmentRequest(appointmentId: id))
    }

    func getPetAppointments(id: UUID, pageParams: PageParams) async throws -> PageResponse<Appointment> {
        return try await apiClient.dispatch(GetPetAppointmentsRequest(petId: id, pageParams: pageParams))
    }

    func createAppointment(body: CreateAppointmentRequestBody) async throws -> Appointment {
        try body.validate()

        return try await apiClient.dispatch(CreateAppointmentRequest(body: body))
    }
}
