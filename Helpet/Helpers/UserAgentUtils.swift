//
//  UserAgentUtils.swift
//  Helpet
//
//  Created by Efim Nikitin on 27.04.2023.
//

import Foundation
import UIKit

struct UserAgentUtils {
    private init() {}

    static func getUserAgent() -> String? {
        guard let info = Bundle.main.infoDictionary,
              let appName = info["CFBundleDisplayName"] ?? info[kCFBundleNameKey as String],
              let version = info["CFBundleShortVersionString"],
              let build = info[kCFBundleVersionKey as String]
        else { return nil }

        let model = UIDevice.current.model
        let systemName = UIDevice.current.systemName
        let systemVersion = UIDevice.current.systemVersion

        let userAgent = "\(appName)/\(version).\(build) (\(model); \(systemName) \(systemVersion))"

        return userAgent
    }
}
