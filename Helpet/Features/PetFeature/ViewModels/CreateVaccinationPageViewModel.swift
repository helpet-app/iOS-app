//
//  CreateVaccinationPageViewModel.swift
//  Helpet
//
//  Created by Efim Nikitin on 18.02.2023.
//

import Foundation
import Combine

final class CreateVaccinationPageViewModel: ObservableObject {
    private let petVaccinationService = PetVaccinationService()

    private let pet: Pet

    @Published var createPetVaccinationInfo = CreatePetVaccinationInfo()

    @Published private(set) var formIsFilled = false

    @Published private(set) var requestStatus: RequestStatus?

    init(pet: Pet) {
        self.pet = pet

        formIsFilledPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: &$formIsFilled)
    }

    @MainActor
    func createPetVaccination() async -> PetVaccination? {
        self.requestStatus = .loading

        do {
            let requestBody = CreatePetVaccinationRequestBody(vaccinationName: createPetVaccinationInfo.vaccinationName,
                                                              comment: createPetVaccinationInfo.comment,
                                                              vaccinatedOn: createPetVaccinationInfo.vaccinatedOn)

            let petVaccination = try await petVaccinationService.createPetVaccination(id: pet.id, body: requestBody)

            self.requestStatus = .success
            return petVaccination
        } catch {
            self.requestStatus = .failure(error: error)
        }

        return nil
    }
}

extension CreateVaccinationPageViewModel {
    private var formIsFilledPublisher: AnyPublisher<Bool, Never> {
        $createPetVaccinationInfo
            .map(\.vaccinationName)
            .removeDuplicates()
            .map { name in
                return !name.isEmpty
            }
            .eraseToAnyPublisher()
    }
}
