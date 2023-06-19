//
//  HTTPHeaderField.swift
//  Helpet
//
//  Created by Efim Nikitin on 10.02.2023.
//

import Foundation

enum HTTPHeaderField: String {
    case authorization = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case acceptLanguage = "Accept-Language"
    case userAgent = "User-Agent"
}
