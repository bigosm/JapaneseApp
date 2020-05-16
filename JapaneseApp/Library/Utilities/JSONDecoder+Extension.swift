//
//  JSONDecoder+Extension.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 15/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

extension JSONDecoder {
    static var iso8601withOptionalFractionalSeconds: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601withOptionalFractionalSeconds
        return decoder
    }
}

extension JSONDecoder.DateDecodingStrategy {
    static let iso8601withOptionalFractionalSeconds = custom {
        let container = try $0.singleValueContainer()
        let string = try container.decode(String.self)
        if let date = Formatter.iso8601WithFractionalSeconds.date(from: string) {
            return date
        } else if let date = Formatter.iso8601.date(from: string) {
            return date
        }
        
        throw DecodingError.dataCorruptedError(
            in: container,
            debugDescription: "Invalid date: " + string)
    }
}
