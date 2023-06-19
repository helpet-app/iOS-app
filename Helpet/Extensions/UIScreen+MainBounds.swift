//
//  UIScreen+MainBounds.swift
//  Helpet
//
//  Created by Efim Nikitin on 03.02.2023.
//

import UIKit

extension UIScreen {
    static var mainBounds: CGRect? {
        return (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.screen.bounds
    }
}
