//
//  GetAppointmentsRequest.swift
//  Helpet
//
//  Created by Efim Nikitin on 31.05.2023.
//

import Foundation

struct GetAppointmentsRequest: Request {
    typealias ReturnType = PageResponse<Appointment>

    let path = "/user/appointments"

    let queryParams: [String: Any]?

    let authorized = true

    init(pageParams: PageParams) {
        self.queryParams = pageParams.asDictionary()
    }
}
