//
//  CreatePetPageViewModel.swift
//  Helpet
//
//  Created by Efim Nikitin on 07.06.2023.
//

import Foundation
import Combine

final class CreatePetPageViewModel: ObservableObject {
    private let petService = PetService()

    private let petCategoryService = PetCategoryService()

    @Published var createPetInfo = CreatePetInfo()

    @Published private(set) var formIsFilled = false

    @Published private(set) var requestStatus: RequestStatus?

    init() {
        formIsFilledPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: &$formIsFilled)
    }

    @MainActor
    func createPet() async -> Pet? {
        self.requestStatus = .loading

        do {
            let requestBody = CreatePetRequestBody(name: createPetInfo.name, petCategoryId: createPetInfo.petCategory!.id)

            let pet = try await petService.createPet(body: requestBody)

            self.requestStatus = .success
            return pet
        } catch {
            self.requestStatus = .failure(error: error)
        }

        return nil
    }
}

extension CreatePetPageViewModel {
    private var nameIsFilledPublisher: AnyPublisher<Bool, Never> {
        $createPetInfo
            .map(\.name)
            .removeDuplicates()
            .map { name in
                return !name.isEmpty
            }
            .eraseToAnyPublisher()
    }

    private var petCategoryIsChosenPublisher: AnyPublisher<Bool, Never> {
        $createPetInfo
            .map(\.petCategory)
            .removeDuplicates()
            .map { petCategory in
                return petCategory != nil
            }
            .eraseToAnyPublisher()
    }

    private var formIsFilledPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(nameIsFilledPublisher, petCategoryIsChosenPublisher)
            .map { nameIsFilled, petCategoryIsChosen in
                return nameIsFilled && petCategoryIsChosen
            }
            .eraseToAnyPublisher()
    }
}
