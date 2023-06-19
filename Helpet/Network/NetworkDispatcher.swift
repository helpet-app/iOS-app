//
//  NetworkDispatcher.swift
//  Helpet
//
//  Created by Efim Nikitin on 10.02.2023.
//

import Foundation

final class NetworkDispatcher {
    private let urlSession: URLSession

    public init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    func dispatch<ReturnType: Codable>(request: URLRequest, decoder: JSONDecoder = .default) async throws -> ReturnType {
        let (data, _) = try await urlSession.data(for: request)

        let response = try decoder.decode(ResponseBody.self, from: data)
        if response.success {
            if ReturnType.self == EmptyResponse.self {
                // swiftlint:disable:next force_cast
                return EmptyResponse() as! ReturnType
            }

            return try decoder.decode(SuccessfulResponseBody<ReturnType>.self, from: data).data
        } else {
            let errors = try decoder.decode(UnsuccessfulResponseBody.self, from: data).errors
            throw BasicError.apiErrors(errors)
        }
    }
}
