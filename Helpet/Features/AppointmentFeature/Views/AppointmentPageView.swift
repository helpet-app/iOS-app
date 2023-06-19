//
//  AppointmentPageView.swift
//  Helpet
//
//  Created by Efim Nikitin on 01.06.2023.
//

import SwiftUI

struct AppointmentPageView: View {
    private let localizedConstants = LocalizedConstants()

    @EnvironmentObject private var notificationHandler: NotificationHandler

    let appointment: Appointment

    var problem: some View {
        InfoRowView(label: localizedConstants.problemLabel, content: appointment.problem)
    }

    @ViewBuilder
    var pet: some View {
        if let pet = appointment.pet {
            CardRowView(image: Image(systemName: "pawprint.fill"),
                        name: localizedConstants.petLabel,
                        value: pet.name)
        }
    }

    @ViewBuilder
    var client: some View {
        if let client = appointment.client {
            CardRowView(image: Image(systemName: "pawprint.fill"),
                        name: localizedConstants.clientLabel,
                        value: client.name)
        }
    }

    var vet: some View {
        CardRowView(image: Image(systemName: "heart.text.square"),
                    name: localizedConstants.vetLabel,
                    value: appointment.vet.name)
    }

    var dateOfAppointment: some View {
        CardRowView(image: Image(systemName: "calendar"),
                    name: localizedConstants.appointmentDateLabel,
                    value: appointment.scheduledAt.formatted(.dateTime.day().month(.wide).hour().minute()))
    }

    var connectionLink: some View {
        InfoRowView(label: localizedConstants.connectionLinkLabel) {
            HStack {
                Text(appointment.connectionLink ?? localizedConstants.noInformationLabel)
                    .frame(maxWidth: .infinity, alignment: .leading)

                if let connectionLink = appointment.connectionLink {
                    Button {
                        UIPasteboard.general.string = connectionLink

                        let notification = CustomNotification(title: localizedConstants.connectionLinkCopiedMessage, hapticFeedbackType: .success)
                        notificationHandler.push(notification: notification)
                    } label: {
                        Image(systemName: "doc.on.doc")
                    }
                }
            }
            .foregroundColor(appointment.connectionLink == nil ? .Foreground.quinary : .Foreground.primary)
        }
    }

    var diagnosis: some View {
        InfoRowView(label: localizedConstants.diagnosisLabel, content: appointment.diagnosis)
    }

    var recommendations: some View {
        InfoRowView(label: localizedConstants.recommendationsLabel, content: appointment.recommendations)
    }

    var body: some View {
        DismissSheet(title: localizedConstants.title) {
            VStack(spacing: DefaultViewConstants.Spacing.large) {
                problem

                CardView {
                    pet

                    client

                    vet

                    dateOfAppointment
                }
                .label(localizedConstants.appointmentInfoLabel)

                connectionLink

                diagnosis

                recommendations
            }
            .padding()
        }
    }
}

extension AppointmentPageView {
    private struct LocalizedConstants {
        let title = Localizer.l10n(key: "APPOINTMENT_PAGE.TITLE")

        let problemLabel = Localizer.l10n(key: "APPOINTMENT_PAGE.PROBLEM_LABEL")

        let appointmentInfoLabel = Localizer.l10n(key: "APPOINTMENT_PAGE.APPOINTMENT_INFO_LABEL")

        let petLabel = Localizer.l10n(key: "APPOINTMENT_PAGE.PET_LABEL")

        let clientLabel = Localizer.l10n(key: "APPOINTMENT_PAGE.CLIENT_LABEL")

        let vetLabel = Localizer.l10n(key: "APPOINTMENT_PAGE.VET_LABEL")

        let appointmentDateLabel = Localizer.l10n(key: "APPOINTMENT_PAGE.APPOINTMENT_DATE_LABEL")

        let connectionLinkLabel = Localizer.l10n(key: "APPOINTMENT_PAGE.CONNECTION_LINK_LABEL")

        let diagnosisLabel = Localizer.l10n(key: "APPOINTMENT_PAGE.DIAGNOSIS_LABEL")

        let recommendationsLabel = Localizer.l10n(key: "APPOINTMENT_PAGE.RECOMMENDATIONS_LABEL")

        let noInformationLabel = Localizer.l10n(key: "INFO_ROW_COMPONENT.NO_INFORMATION_LABEL")

        let connectionLinkCopiedMessage = Localizer.l10n(key: "APPOINTMENT_PAGE.CONNECTION_LINK_COPIED_MESSAGE")
    }
}

struct AppointmentPageView_Previews: PreviewProvider {
    static var previews: some View {
        AppointmentPageView(appointment: Appointment(id: UUID(),
                                                     problem: "Боль в глазах",
                                                     diagnosis: "Конъюнктивит",
                                                     recommendations: "Глазные капли ФОРВЕТ по одной капле 4-5 раз в день",
                                                     status: .scheduled,
                                                     scheduledAt: Date().addingTimeInterval(60 * 60 * 24),
                                                     createdAt: Date(),
                                                     vet: Appointment.Participant(id: UUID(), name: "Иванов Петр Сергеевич"),
                                                     pet: Appointment.Participant(id: UUID(), name: "Симба")))
    }
}
