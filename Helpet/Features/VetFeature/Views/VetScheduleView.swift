//
//  VetScheduleView.swift
//  Helpet
//
//  Created by Efim Nikitin on 02.06.2023.
//

import SwiftUI

struct VetScheduleView: View {
    private let columns = [GridItem(.flexible(minimum: 40))] + Array(repeating: GridItem(.flexible()), count: 7)

    private let weekdays: [String] = {
        var weekdays = Calendar.current.shortWeekdaySymbols
        weekdays.append(weekdays.removeFirst())
        return weekdays
    }()

    let slots: [VetScheduleSlot]

    var body: some View {
        VStack {
            LazyVGrid(columns: columns) {
                Text("")

                ForEach(weekdays, id: \.self) { weekday in
                    Text(weekday)
                }

                ForEach(slots) { slot in
                    Text(slot.timeSlot.startTime.formatted(.dateTime.hour().minute()))

                    makeMark(isActive: slot.monday)
                    makeMark(isActive: slot.tuesday)
                    makeMark(isActive: slot.wednesday)
                    makeMark(isActive: slot.thursday)
                    makeMark(isActive: slot.friday)
                    makeMark(isActive: slot.saturday)
                    makeMark(isActive: slot.sunday)
                }
            }
        }
        .font(.footnote.weight(.medium))
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.Background.secondary)
        .rounded()
    }

    @ViewBuilder
    private func makeMark(isActive: Bool) -> some View {
        Circle()
            .foregroundColor(isActive ? .Foreground.primary : .Background.tertiary)
            .frame(maxWidth: 20)
    }
}
