//
//  APIClient.swift
//  Helpet
//
//  Created by Efim Nikitin on 10.02.2023.
//

import Foundation

final class APIClient {
    private let baseURL: String

    private let networkDispatcher: NetworkDispatcher

    private let decoder: JSONDecoder

    init(baseURL: String, networkDispatcher: NetworkDispatcher = NetworkDispatcher(), decoder: JSONDecoder = .default) {
        self.baseURL = baseURL
        self.networkDispatcher = networkDispatcher
        self.decoder = decoder
    }

    func dispatch<R: Request>(_ request: R) async throws -> R.ReturnType {
        if request.authorized {
            try await AuthManager.shared.refreshAuthIfNeeded()
        }

        guard let urlRequest = request.asURLRequest(baseURL: baseURL) else {
            throw BasicError.unknownError
        }

        return try await networkDispatcher.dispatch(request: urlRequest, decoder: decoder)
    }
}
