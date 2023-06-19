//
//  GetPetCategoriesRequest.swift
//  Helpet
//
//  Created by Efim Nikitin on 07.06.2023.
//

import Foundation

struct GetPetCategoriesRequest: Request {
    typealias ReturnType = [PetCategory]

    let path = "/pet-categories"

    let authorized = true
}
