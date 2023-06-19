//
//  FamilyPageViewModel.swift
//  Helpet
//
//  Created by Efim Nikitin on 26.01.2023.
//

import Foundation

final class FamilyPageViewModel: ObservableObject {
    private let petService = PetService()

    private let familyService = FamilyService()

    @Published var pets: [Pet] = []

    @Published var familiesMembers: [FamilyMember] = []

    @Published var families: [Family] = []

    @Published private(set) var tabsRequestStatuses: [FamilyPageTabViewModel.TabType: RequestStatus] = [:]

    @MainActor
    func fetchPets() async {
        await fetchData(for: .pets) {
            self.pets = try await self.petService.getPets()
        }
    }

    @MainActor
    func fetchFamilies() async {
        await fetchData(for: .families) {
            self.families = try await self.familyService.getFamilies()
        }
    }

    @MainActor
    func fetchFamiliesMembers() async {
        await fetchData(for: .familiesMembers) {
            self.familiesMembers = try await self.familyService.getFamiliesMembers()
        }
    }

    @MainActor
    private func fetchData(for tab: FamilyPageTabViewModel.TabType, function: @escaping () async throws -> Void) async {
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
