//
//  ContentView.swift
//  Helpet
//
//  Created by Efim Nikitin on 16.01.2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var sceneDelegate: SceneDelegate

    @StateObject private var appState = AppState()

    var body: some View {
        Group {
            if appState.isAuthenticated {
                TabBarView()
            } else {
                SignInPageView()
            }
        }
        .progressViewStyle(SpinnerProgressViewStyle())
        .tint(Color.Foreground.primary)
        .environmentObject(sceneDelegate.notificationHandler)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
