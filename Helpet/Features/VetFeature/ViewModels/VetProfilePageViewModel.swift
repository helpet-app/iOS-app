//
//  VetProfilePageViewModel.swift
//  Helpet
//
//  Created by Efim Nikitin on 09.02.2023.
//

import Foundation

final class VetProfilePageViewModel: ObservableObject {
    private let vetService = VetService()

    @Published var vet: Vet

    @Published var vetTariffs: [VetTariff] = []

    @Published var vetContacts: [VetContact] = []

    @Published var vetSchedule: [VetScheduleSlot] = []

    @Published var tabsRequestStatuses: [VetProfileTabViewModel.TabType: RequestStatus] = [:]

    init(vet: Vet) {
        self.vet = vet
    }

    @MainActor
    func fetchVetTariffs() async {
        await fetchData(for: .tariffs) {
            self.vetTariffs = try await self.vetService.getVetTariffs(id: self.vet.id)
        }
    }

    @MainActor
    func fetchVetContacts() async {
        await fetchData(for: .contacts) {
            self.vetContacts = try await self.vetService.getVetContacts(id: self.vet.id)
        }
    }

    @MainActor
    func fetchVetSchedule() async {
        await fetchData(for: .schedule) {
            self.vetSchedule = try await self.vetService.getVetSchedule(id: self.vet.id)
        }
    }

    @MainActor
    private func fetchData(for tab: VetProfileTabViewModel.TabType, function: @escaping () async throws -> Void) async {
        if tabsRequestStatuses[tab] == nil {
            self.tabsRequestStatuses[tab] = .loading
        }

        do {
            try await function()

            self.tabsRequestStatuses[tab] = .success
        } catch {
            self.tabsRequestStatuses[tab] = .failure(error: error)
        }
    }
}
