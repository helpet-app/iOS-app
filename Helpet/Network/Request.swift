//
//  Request.swift
//  Helpet
//
//  Created by Efim Nikitin on 10.02.2023.
//

import Foundation

protocol Request {
    associatedtype ReturnType: Codable

    var path: String { get }

    var method: HTTPMethod { get }

    var contentType: HTTPContentType { get }

    var queryParams: [String: Any]? { get }

    var body: [String: Any]? { get }

    var headers: [String: String]? { get }

    var authorized: Bool { get }
}

extension Request {
    var method: HTTPMethod { return .get }

    var contentType: HTTPContentType { return .json }

    var queryParams: [String: Any]? { return nil }

    var body: [String: Any]? { return nil }

    var headers: [String: String]? { return nil }

    var authorized: Bool { return false }
}
