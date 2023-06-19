//
//  URLCache+Default.swift
//  Helpet
//
//  Created by Efim Nikitin on 14.06.2023.
//

import Foundation

extension URLCache {
    static let shared = {
        URLCache(memoryCapacity: CacheConfig.memoryCapacity, diskCapacity: CacheConfig.diskCapacity)
    }()
}
