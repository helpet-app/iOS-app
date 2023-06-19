//
//  SceneDelegate.swift
//  Helpet
//
//  Created by Efim Nikitin on 21.01.2023.
//

import UIKit
import SwiftUI

class SceneDelegate: NSObject, UIWindowSceneDelegate, ObservableObject {
    var window: UIWindow?

    weak var windowScene: UIWindowScene?

    var notificationHandler = NotificationHandler()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        self.windowScene = windowScene

        setUpNotificationWindow()

        UIConfig().setUp()
    }

    func sceneDidDisconnect(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {

    }

    func sceneDidEnterBackground(_ scene: UIScene) {

    }

    private func setUpNotificationWindow() {
        guard let windowScene = windowScene else { return }

        let rootView = NotificationBannerRootView().environmentObject(notificationHandler)
        let notificationViewController = UIHostingController(rootView: rootView)
        notificationViewController.view.backgroundColor = .clear

        let notificationWindow = PassThroughWindow(windowScene: windowScene)
        notificationWindow.rootViewController = notificationViewController
        notificationWindow.isHidden = false

        self.window = notificationWindow
    }
}

private class PassThroughWindow: UIWindow {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let hitView = super.hitTest(point, with: event) else { return nil }
        return rootViewController?.view == hitView ? nil : hitView
    }
}
