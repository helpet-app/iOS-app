//
//  AppointmentListRowView.swift
//  Helpet
//
//  Created by Efim Nikitin on 02.02.2023.
//

import SwiftUI

struct AppointmentListRowView: View {
    let appointment: Appointment

    var participants: some View {
        HStack(spacing: 0) {
            if let pet = appointment.pet {
                Text(pet.name)
                    .fontWeight(.semibold)
                    .foregroundColor(.Foreground.primary)

                Text(", \(appointment.vet.name)")
            } else {
                Text(appointment.vet.name)
                    .foregroundColor(.Foreground.primary)
                    .fontWeight(.semibold)

                if let client = appointment.client {
                    Text(", \(client.name)")
                }
            }
        }
        .font(.subheadline)
    }

    var problem: some View {
        Text("\(appointment.scheduledAt.formatted(.dateTime.hour().minute())), \(appointment.problem)")
            .font(.footnote)
    }

    var body: some View {
        ListRowView(imageName: "calendar.badge.clock") {
            VStack(alignment: .leading, spacing: DefaultViewConstants.Spacing.extraSmall) {
                participants

                problem
            }
            .foregroundColor(.Foreground.quinary)
        }
    }
}

struct AppointmentCardView_Previews: PreviewProvider {
    static var previews: some View {
        AppointmentsFeedPageView()
    }
}
