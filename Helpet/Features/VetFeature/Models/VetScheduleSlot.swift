//
//  VetScheduleSlot.swift
//  Helpet
//
//  Created by Efim Nikitin on 02.06.2023.
//

import Foundation

struct VetScheduleSlot: Identifiable, Codable {
    var id: UUID

    var timeSlot: TimeSlot

    var monday: Bool

    var tuesday: Bool

    var wednesday: Bool

    var thursday: Bool

    var friday: Bool

    var saturday: Bool

    var sunday: Bool
}
