//
//  GetVetFreeTimeSlotsRequest.swift
//  Helpet
//
//  Created by Efim Nikitin on 18.06.2023.
//

import Foundation

struct GetVetFreeTimeSlotsRequest: Request {
    typealias ReturnType = [TimeSlot]

    let path: String

    let queryParams: [String: Any]?

    let authorized = true

    init(vetId: UUID, date: Date) {
        self.path = "/vets/\(vetId)/free-time-slots"
        var queryParams = [String: Any]()
        queryParams["date"] = date.formatted(.iso8601.year().month().day())
        self.queryParams = queryParams
    }
}
