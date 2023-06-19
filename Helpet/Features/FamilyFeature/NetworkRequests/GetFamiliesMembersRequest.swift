//
//  GetFamiliesMembersRequest.swift
//  Helpet
//
//  Created by Efim Nikitin on 05.06.2023.
//

import Foundation

struct GetFamiliesMembersRequest: Request {
    typealias ReturnType = [FamilyMember]

    let path = "/user/families/members"

    let authorized = true
}
