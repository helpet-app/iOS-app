//
//  CreateAppointmentRequest.swift
//  Helpet
//
//  Created by Efim Nikitin on 18.06.2023.
//

import Foundation

struct CreateAppointmentRequest: Request {
    typealias ReturnType = Appointment

    let path = "/user/appointments"

    let method: HTTPMethod = .post

    let body: [String: Any]?

    let authorized = true

    init(body: CreateAppointmentRequestBody) {
        self.body = body.asDictionary()
    }
}
