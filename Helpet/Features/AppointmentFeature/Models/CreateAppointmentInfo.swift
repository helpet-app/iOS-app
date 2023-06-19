//
//  CreateAppointmentInfo.swift
//  Helpet
//
//  Created by Efim Nikitin on 18.06.2023.
//

import Foundation

struct CreateAppointmentInfo {
    var problem: String = ""

    var pet: Pet?

    var date: Date = Calendar.current.date(byAdding: .day, value: 1, to: Date())!

    var timeSlot: TimeSlot?
}
