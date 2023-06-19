//
//  JSONDecoder+Default.swift
//  Helpet
//
//  Created by Efim Nikitin on 08.05.2023.
//

import Foundation

extension JSONDecoder {
    static var `default`: JSONDecoder {
        let decoder = JSONDecoder()

        decoder.dateDecodingStrategy = .custom { decoder -> Date in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)

            if let fullDateWithoutMilliseconds = tryDecodeFullDateWithoutMilliseconds(dateString) {
                return fullDateWithoutMilliseconds
            }

            if let fullDateWithMilliseconds = tryDecodeFullDateWithMilliseconds(dateString) {
                return fullDateWithMilliseconds
            }

            if let dateWithoutTime = tryDecodeDateWithoutTime(dateString) {
                return dateWithoutTime
            }

            if let timeWithoutDate = tryDecodeTimeWithoutDate(dateString) {
                return timeWithoutDate
            }

            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date format: \(dateString)")
        }

        return decoder
    }

    private static func tryDecodeFullDateWithoutMilliseconds(_ string: String) -> Date? {
        let formatter = ISO8601DateFormatter()

        return formatter.date(from: string)
    }

    private static func tryDecodeFullDateWithMilliseconds(_ string: String) -> Date? {
        let formatter = ISO8601DateFormatter()

        formatter.formatOptions.insert(.withFractionalSeconds)

        return formatter.date(from: string)
    }

    private static func tryDecodeDateWithoutTime(_ string: String) -> Date? {
        let formatter = ISO8601DateFormatter()

        formatter.formatOptions.remove(.withFullTime)

        return formatter.date(from: string)
    }

    private static func tryDecodeTimeWithoutDate(_ string: String) -> Date? {
        var string = string
        string.removeLast()

        let currentDateString = Date().formatted(.iso8601.year().month().day())
        let modifiedDateString = currentDateString + "T" + string + ":00Z"

        return tryDecodeFullDateWithoutMilliseconds(modifiedDateString)
    }
}
