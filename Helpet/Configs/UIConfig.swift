//
//  UIConfig.swift
//  Helpet
//
//  Created by Efim Nikitin on 18.01.2023.
//

import SwiftUI

struct UIConfig {
    func setUp() {
        ColorSchemeState.shared.applyColorScheme()

        setUpUINavigationBarAppearance()

        setUpUITabBarAppearance()

        setUpUIPageControlAppearance()
    }

    private func setUpUINavigationBarAppearance() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.Foreground.primary)]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.Foreground.primary)]
    }

    private func setUpUITabBarAppearance() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        tabBarAppearance.backgroundColor = UIColor(Color.Background.primary)

        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.Foreground.primary.opacity(0.5))
    }

    private func setUpUIPageControlAppearance() {
        UIPageControl.appearance().pageIndicatorTintColor = UIColor(Color.Background.quaternary)
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(Color.Foreground.primary)
    }
}
