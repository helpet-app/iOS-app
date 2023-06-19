//
//  RequestStatusModifier.swift
//  Helpet
//
//  Created by Efim Nikitin on 06.06.2023.
//

import SwiftUI

struct RequestStatusModifier: ViewModifier {
    @EnvironmentObject private var notificationHandler: NotificationHandler

    let requestStatus: RequestStatus?

    func body(content: Content) -> some View {
        content
            .overlay {
                if case .loading = requestStatus {
                    SpinnerProgressView()
                }
            }
            .onChange(of: requestStatus) { newRequestStatus in
                if case .failure(let error) = newRequestStatus {
                    let error = BasicError(from: error)
                    let notification = CustomNotification(title: error.errorTitle, message: error.localizedDescription, hapticFeedbackType: .error)
                    notificationHandler.push(notification: notification)
                }
            }
            .ignoresSafeArea(.keyboard)
    }
}

extension View {
    func requestStatus(_ requestStatus: RequestStatus?) -> some View {
        modifier(RequestStatusModifier(requestStatus: requestStatus))
    }
}
