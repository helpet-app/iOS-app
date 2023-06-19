//
//  Request+Helpers.swift
//  Helpet
//
//  Created by Efim Nikitin on 10.02.2023.
//

import Foundation

extension Request {
    func asURLRequest(baseURL: String) -> URLRequest? {
        guard var urlComponents = URLComponents(string: baseURL) else { return nil }

        urlComponents.path = "\(urlComponents.path)\(path)"
        urlComponents.queryItems = getQueryItemsFrom(params: queryParams)

        guard let finalURL = urlComponents.url else { return nil }

        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        request.httpBody = getRequestBodyFrom(params: body)

        var defaultHeaders: [String: String] = getDefaultHeaders()

        if self.authorized, let accessToken = TokenManager.shared.getAccessToken() {
            defaultHeaders[HTTPHeaderField.authorization.rawValue] = "\(accessToken.type) \(accessToken.value)"
        }

        request.allHTTPHeaderFields = defaultHeaders.merging(headers ?? [:], uniquingKeysWith: { (first, _) in first })

        return request
    }

    private func getRequestBodyFrom(params: [String: Any]?) -> Data? {
        guard let params = params else { return nil }

        guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else { return nil }

        return httpBody
    }

    private func getQueryItemsFrom(params: [String: Any]?) -> [URLQueryItem]? {
        guard let params = params else { return nil }

        var result: [URLQueryItem] = []

        for param in params {
            if let paramContent = param.value as? any Collection, !(paramContent is String) {
                for paramValue in paramContent {
                    result.append(URLQueryItem(name: param.key, value: String(describing: paramValue)))
                }
            } else {
                result.append(URLQueryItem(name: param.key, value: String(describing: param.value)))
            }
        }

        return result
    }

    private func getDefaultHeaders() -> [String: String] {
        var defaultHeaders: [String: String] = [
            HTTPHeaderField.contentType.rawValue: contentType.rawValue,
            HTTPHeaderField.acceptType.rawValue: contentType.rawValue
        ]

        if let languageCode = Locale.current.language.languageCode?.identifier {
            defaultHeaders[HTTPHeaderField.acceptLanguage.rawValue] = languageCode
        }

        if let userAgent = UserAgentUtils.getUserAgent() {
            defaultHeaders[HTTPHeaderField.userAgent.rawValue] = userAgent
        }

        return defaultHeaders
    }
}
