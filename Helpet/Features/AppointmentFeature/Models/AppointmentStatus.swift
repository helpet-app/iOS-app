//
//  AppointmentStatus.swift
//  Helpet
//
//  Created by Efim Nikitin on 02.02.2023.
//

import Foundation

enum AppointmentStatus: String, Codable {
    case scheduled = "SCHEDULED"
    case canceled = "CANCELED"
    case completed = "COMPLETED"
}
