//
//  FamilyMember.swift
//  Helpet
//
//  Created by Efim Nikitin on 25.01.2023.
//

import Foundation

struct FamilyMember: Identifiable, Codable {
    var id: UUID

    var username: String

    var name: String

    var avatarUrl: String?
}
