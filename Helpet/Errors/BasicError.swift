//
//  BasicError.swift
//  Helpet
//
//  Created by Efim Nikitin on 10.02.2023.
//

import Foundation

enum BasicError: LocalizedError {
    case validationError(_ error: ValidationErrorProtocol)
    case missingTokenError
    case apiErrors(_ errors: [APIError])
    case decodingError
    case urlSessionError(_ error: URLError)
    case unknownError

    init(from error: Error) {
        switch error {
        case is DecodingError:
            self = .decodingError
        case let urlError as URLError:
            self = .urlSessionError(urlError)
        case let error as ValidationErrorProtocol:
            self = .validationError(error)
        case let error as BasicError:
            self = error
        default:
            self = .unknownError
        }
    }

    var errorTitle: String {
        switch self {
        case .validationError:
            return Localizer.l10n(key: "BASIC_ERROR.VALIDATION_ERROR_TITLE")
        case .missingTokenError:
            return Localizer.l10n(key: "BASIC_ERROR.MISSING_TOKEN_ERROR_TITLE")
        case .apiErrors:
            return Localizer.l10n(key: "BASIC_ERROR.API_ERRORS_TITLE")
        case .decodingError:
            return Localizer.l10n(key: "BASIC_ERROR.DECODING_ERROR_TITLE")
        case .urlSessionError:
            return Localizer.l10n(key: "BASIC_ERROR.URL_SESSION_ERROR_TITLE")
        case .unknownError:
            return Localizer.l10n(key: "BASIC_ERROR.UNKNOWN_ERROR_TITLE")
        }
    }

    var errorDescription: String? {
        switch self {
        case .validationError(let error):
            return error.localizedDescription
        case .missingTokenError:
            return Localizer.l10n(key: "BASIC_ERROR.MISSING_TOKEN_ERROR_MESSAGE")
        case .apiErrors(let errors):
            return errors.map(\.message).joined(separator: ". ")
        case .decodingError:
            return Localizer.l10n(key: "BASIC_ERROR.DECODING_ERROR_MESSAGE")
        case .urlSessionError:
            return Localizer.l10n(key: "BASIC_ERROR.URL_SESSION_ERROR_MESSAGE")
        case .unknownError:
            return Localizer.l10n(key: "BASIC_ERROR.UNKNOWN_ERROR_MESSAGE")
        }
    }
}
