//
//  CreateDiseasePageViewModel.swift
//  Helpet
//
//  Created by Efim Nikitin on 17.02.2023.
//

import Foundation
import Combine

final class CreateDiseasePageViewModel: ObservableObject {
    private let petDiseaseService = PetDiseaseService()

    private let pet: Pet

    @Published var createPetDiseaseInfo = CreatePetDiseaseInfo()

    @Published private(set) var formIsFilled = false

    @Published private(set) var requestStatus: RequestStatus?

    init(pet: Pet) {
        self.pet = pet

        formIsFilledPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: &$formIsFilled)
    }

    @MainActor
    func createPetDisease() async -> PetDisease? {
        self.requestStatus = .loading

        do {
            let requestBody = CreatePetDiseaseRequestBody(diseaseName: createPetDiseaseInfo.diseaseName,
                                                          comment: createPetDiseaseInfo.comment,
                                                          gotSickOn: createPetDiseaseInfo.gotSickOn,
                                                          recoveredOn: createPetDiseaseInfo.alreadyRecovered ? createPetDiseaseInfo.recoveredOn : nil)

            let petDisease = try await petDiseaseService.createPetDisease(id: pet.id, body: requestBody)

            self.requestStatus = .success
            return petDisease
        } catch {
            self.requestStatus = .failure(error: error)
        }

        return nil
    }
}

extension CreateDiseasePageViewModel {
    private var formIsFilledPublisher: AnyPublisher<Bool, Never> {
        $createPetDiseaseInfo
            .map(\.diseaseName)
            .removeDuplicates()
            .map { name in
                return !name.isEmpty
            }
            .eraseToAnyPublisher()
    }
}
