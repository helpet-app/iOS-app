//
//  Family.swift
//  Helpet
//
//  Created by Efim Nikitin on 05.06.2023.
//

import Foundation

struct Family: Identifiable, Codable {
    var id: UUID

    var name: String

    var createdBy: FamilyMember
}
