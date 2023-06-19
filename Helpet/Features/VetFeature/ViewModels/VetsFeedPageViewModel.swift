//
//  VetsFeedPageViewModel.swift
//  Helpet
//
//  Created by Efim Nikitin on 09.02.2023.
//

import Foundation

final class VetsFeedPageViewModel: ObservableObject {
    private let vetService = VetService()

    private var pageParams = PageParams()

    @Published private(set) var vets: [Vet] = []

    @Published private(set) var requestStatus: RequestStatus?

    init() {
        self.requestStatus = .loading

        Task {
            await fetchVets()
        }
    }

    @MainActor
    func fetchVets() async {
        do {
            self.vets = try await vetService.getVets(pageParams: PageParams()).content

            self.requestStatus = .success
        } catch {
            self.requestStatus = .failure(error: error)
        }
    }
}
