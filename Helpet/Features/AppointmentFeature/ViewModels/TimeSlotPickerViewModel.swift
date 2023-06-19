//
//  TimeSlotPickerViewModel.swift
//  Helpet
//
//  Created by Efim Nikitin on 18.06.2023.
//

import Foundation

final class TimeSlotPickerViewModel: PickerPageViewModel {
    private let vetService = VetService()

    private let vet: Vet

    @Published var date: Date

    @Published private(set) var items: [TimeSlot] = []

    @Published var selectedItem: TimeSlot?

    @Published var requestStatus: RequestStatus?

    init(vet: Vet, date: Date) {
        self.vet = vet
        self.date = date
    }

    @MainActor
    func fetchItems() async {
        if requestStatus == nil {
            self.requestStatus = .loading
        }

        do {
            self.items = try await vetService.getVetFreeTimeSlots(id: vet.id, date: date)

            self.requestStatus = .success
        } catch {
            self.requestStatus = .failure(error: error)
        }
    }
}
