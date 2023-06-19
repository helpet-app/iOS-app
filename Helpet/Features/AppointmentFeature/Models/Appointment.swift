//
//  Appointment.swift
//  Helpet
//
//  Created by Efim Nikitin on 31.05.2023.
//

import Foundation

struct Appointment: Identifiable, Codable {
    var id: UUID

    var problem: String

    var connectionLink: String?

    var diagnosis: String?

    var recommendations: String?

    var status: AppointmentStatus

    var scheduledAt: Date

    var createdAt: Date

    var vet: Participant

    var pet: Participant?

    var client: Participant?

    struct Participant: Identifiable, Codable {
        var id: UUID

        var name: String

        var avatarUrl: String?
    }
}
