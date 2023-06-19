//
//  RequestStatus.swift
//  Helpet
//
//  Created by Efim Nikitin on 06.06.2023.
//

import Foundation

enum RequestStatus: Equatable {
    case loading
    case success
    case failure(error: Error)

    static func == (lhs: RequestStatus, rhs: RequestStatus) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case (.success, .success):
            return true
        case (let .failure(lhsError), let .failure(rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
}
