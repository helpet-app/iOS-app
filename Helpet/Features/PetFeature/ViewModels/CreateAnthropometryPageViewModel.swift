//
//  CreateAnthropometryPageViewModel.swift
//  Helpet
//
//  Created by Efim Nikitin on 13.02.2023.
//

import Foundation
import Combine

final class CreateAnthropometryPageViewModel: ObservableObject {
    private let petAnthropometryService = PetAnthropometryService()

    private let pet: Pet

    @Published var createPetAnthropometryInfo = CreatePetAnthropometryInfo()

    @Published private(set) var formIsFilled = false

    @Published private(set) var requestStatus: RequestStatus?

    init(pet: Pet) {
        self.pet = pet

        formIsFilledPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: &$formIsFilled)
    }

    @MainActor
    func createPetAnthropometry() async -> PetAnthropometry? {
        self.requestStatus = .loading

        do {
            let requestBody = CreatePetAnthropometryRequestBody(height: createPetAnthropometryInfo.height ?? 0,
                                                                weight: createPetAnthropometryInfo.weight ?? 0,
                                                                comment: createPetAnthropometryInfo.comment)

            let petAnthropometry = try await petAnthropometryService.createPetAnthropometry(id: pet.id, body: requestBody)

            self.requestStatus = .success
            return petAnthropometry
        } catch {
            self.requestStatus = .failure(error: error)
        }

        return nil
    }
}

extension CreateAnthropometryPageViewModel {
    private var heightIsFilledPublisher: AnyPublisher<Bool, Never> {
        $createPetAnthropometryInfo
            .map(\.height)
            .removeDuplicates()
            .map { height in
                return height != nil
            }
            .eraseToAnyPublisher()
    }

    private var weightIsFilledPublisher: AnyPublisher<Bool, Never> {
        $createPetAnthropometryInfo
            .map(\.weight)
            .removeDuplicates()
            .map { weight in
                return weight != nil
            }
            .eraseToAnyPublisher()
    }

    private var formIsFilledPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(heightIsFilledPublisher, weightIsFilledPublisher)
            .map { heightIsFilled, weightIsFilled in
                return heightIsFilled && weightIsFilled
            }
            .eraseToAnyPublisher()
    }
}
