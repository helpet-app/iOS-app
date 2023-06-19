//
//  NotificationHandler.swift
//  Helpet
//
//  Created by Efim Nikitin on 15.06.2023.
//

import Foundation
import SwiftUI

struct CustomNotification: Identifiable, Equatable {
    var id: UUID = UUID()

    var title: String

    var message: String?

    var duration: TimeInterval = 3

    var hapticFeedbackType: UINotificationFeedbackGenerator.FeedbackType?

    static func == (lhs: CustomNotification, rhs: CustomNotification) -> Bool {
        return lhs.id == rhs.id
    }
}

final class NotificationHandler: ObservableObject {
    private let feedbackGenerator = UINotificationFeedbackGenerator()

    private var task: Task<Void, Never>?

    @Published private(set) var currentNotification: CustomNotification?

    func push(notification: CustomNotification) {
        self.feedbackGenerator.prepare()

        task?.cancel()

        self.task = Task {
            await MainActor.run {
                self.currentNotification = notification
                if let hapticFeedbackType = self.currentNotification?.hapticFeedbackType {
                    self.feedbackGenerator.notificationOccurred(hapticFeedbackType)
                }
            }

            try? await Task.sleep(for: .seconds(notification.duration))

            await MainActor.run {
                self.currentNotification = nil
            }
        }
    }

    func remove() {
        task?.cancel()
    }
}
