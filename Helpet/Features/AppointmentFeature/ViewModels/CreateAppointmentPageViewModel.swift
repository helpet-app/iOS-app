//
//  CreateAppointmentPageViewModel.swift
//  Helpet
//
//  Created by Efim Nikitin on 18.06.2023.
//

import Foundation
import Combine

final class CreateAppointmentPageViewModel: ObservableObject {
    private let appointmentService = AppointmentService()

    @Published private(set) var vet: Vet

    @Published var createAppointmentInfo = CreateAppointmentInfo()

    @Published private(set) var formIsFilled = false

    @Published private(set) var requestStatus: RequestStatus?

    init(vet: Vet) {
        self.vet = vet

        formIsFilledPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: &$formIsFilled)
    }

    @MainActor
    func createAppointment() async -> Bool {
        self.requestStatus = .loading

        do {
            let requestBody = CreateAppointmentRequestBody(problem: createAppointmentInfo.problem,
                                                           vetId: vet.id,
                                                           petId: createAppointmentInfo.pet!.id,
                                                           date: createAppointmentInfo.date,
                                                           timeSlotId: createAppointmentInfo.timeSlot!.id)

            _ = try await appointmentService.createAppointment(body: requestBody)

            self.requestStatus = .success

            return true
        } catch {
            self.requestStatus = .failure(error: error)
        }

        return false
    }
}

extension CreateAppointmentPageViewModel {
    private var problemIsFilledPublisher: AnyPublisher<Bool, Never> {
        $createAppointmentInfo
            .map(\.problem)
            .removeDuplicates()
            .map { problem in
                return !problem.isEmpty
            }
            .eraseToAnyPublisher()
    }

    private var petIsChosenPublisher: AnyPublisher<Bool, Never> {
        $createAppointmentInfo
            .map(\.pet)
            .removeDuplicates()
            .map { pet in
                return pet != nil
            }
            .eraseToAnyPublisher()
    }

    private var timeSlotIsChosenPublisher: AnyPublisher<Bool, Never> {
        $createAppointmentInfo
            .map(\.timeSlot)
            .removeDuplicates()
            .map { timeSlot in
                return timeSlot != nil
            }
            .eraseToAnyPublisher()
    }

    private var formIsFilledPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest3(problemIsFilledPublisher, petIsChosenPublisher, timeSlotIsChosenPublisher)
            .map { problemIsFilled, petIsChosen, timeSlotIsChosen in
                return problemIsFilled && petIsChosen && timeSlotIsChosen
            }
            .eraseToAnyPublisher()
    }
}
