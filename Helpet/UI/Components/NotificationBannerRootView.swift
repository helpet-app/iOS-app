//
//  NotificationBannerRootView.swift
//  Helpet
//
//  Created by Efim Nikitin on 15.06.2023.
//

import SwiftUI

struct NotificationBannerRootView: View {
    @EnvironmentObject var handler: NotificationHandler

    var body: some View {
        VStack {
            if let notification = handler.currentNotification {
                NotificationBannerView(title: notification.title, message: notification.message)
                    .id(notification.id)
                    .onTapGesture {
                        handler.remove()
                    }
                    .transition(.slide)

                Spacer()
            }
        }
        .animation(.default, value: handler.currentNotification)
    }
}

struct NotificationBannerRootView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationBannerRootView()
    }
}
