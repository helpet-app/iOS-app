//
//  TimeSlot.swift
//  Helpet
//
//  Created by Efim Nikitin on 02.06.2023.
//

import Foundation

struct TimeSlot: Identifiable, Hashable, Codable {
    var id: Int

    var startTime: Date

    var endTime: Date
}
