//
//  CreatePetFeaturePageViewModel.swift
//  Helpet
//
//  Created by Efim Nikitin on 13.02.2023.
//

import Foundation
import Combine

final class CreatePetFeaturePageViewModel: ObservableObject {
    private let petFeatureService = PetFeatureService()

    private let pet: Pet

    @Published var createPetFeatureInfo = CreatePetFeatureInfo()

    @Published private(set) var formIsFilled = false

    @Published private(set) var requestStatus: RequestStatus?

    init(pet: Pet) {
        self.pet = pet

        formIsFilledPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: &$formIsFilled)
    }

    @MainActor
    func createPetFeature() async -> PetFeature? {
        self.requestStatus = .loading

        do {
            let requestBody = CreatePetFeatureRequestBody(name: createPetFeatureInfo.name, description: createPetFeatureInfo.description)

            let petFeature = try await petFeatureService.createPetFeature(id: pet.id, body: requestBody)

            self.requestStatus = .success
            return petFeature
        } catch {
            self.requestStatus = .failure(error: error)
        }

        return nil
    }
}

extension CreatePetFeaturePageViewModel {
    private var nameIsFilledPublisher: AnyPublisher<Bool, Never> {
        $createPetFeatureInfo
            .map(\.name)
            .removeDuplicates()
            .map { name in
                return !name.isEmpty
            }
            .eraseToAnyPublisher()
    }

    private var descriptionIsFilledPublisher: AnyPublisher<Bool, Never> {
        $createPetFeatureInfo
            .map(\.description)
            .removeDuplicates()
            .map { description in
                return !description.isEmpty
            }
            .eraseToAnyPublisher()
    }

    private var formIsFilledPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(nameIsFilledPublisher, descriptionIsFilledPublisher)
            .map { nameIsFilled, descriptionIsFilled in
                return nameIsFilled && descriptionIsFilled
            }
            .eraseToAnyPublisher()
    }
}
