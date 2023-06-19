//
//  VetService.swift
//  Helpet
//
//  Created by Efim Nikitin on 31.05.2023.
//

import Foundation

final class VetService {
    private let apiClient = APIClient(baseURL: APIConfig.Service.vetServiceURL)

    private let apiClientForTimeSlots = APIClient(baseURL: APIConfig.Service.appointmentServiceURL)

    func getVets(pageParams: PageParams, tags: [UUID] = []) async throws -> PageResponse<Vet> {
        return try await apiClient.dispatch(GetVetsRequest(pageParams: pageParams, tags: tags))
    }

    func getVet(id: UUID) async throws -> Vet {
        return try await apiClient.dispatch(GetVetRequest(vetId: id))
    }

    func getVetTariffs(id: UUID) async throws -> [VetTariff] {
        return try await apiClient.dispatch(GetVetTariffsRequest(vetId: id))
    }

    func getVetContacts(id: UUID) async throws -> [VetContact] {
        return try await apiClient.dispatch(GetVetContactsRequest(vetId: id))
    }

    func getVetSchedule(id: UUID) async throws -> [VetScheduleSlot] {
        return try await apiClient.dispatch(GetVetScheduleRequest(vetId: id))
    }

    func getVetFreeTimeSlots(id: UUID, date: Date) async throws -> [TimeSlot] {
        return try await apiClientForTimeSlots.dispatch(GetVetFreeTimeSlotsRequest(vetId: id, date: date))
    }
}
