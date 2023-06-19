//
//  GetAppointmentRequest.swift
//  Helpet
//
//  Created by Efim Nikitin on 31.05.2023.
//

import Foundation

struct GetAppointmentRequest: Request {
    typealias ReturnType = Appointment

    let path: String

    let authorized = true

    init(appointmentId: UUID) {
        self.path = "/user/appointments/\(appointmentId)"
    }
}
