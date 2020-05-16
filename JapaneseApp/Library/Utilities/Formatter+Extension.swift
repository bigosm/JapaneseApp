//
//  Formatter.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 15/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

extension Formatter {
    static let iso8601WithFractionalSeconds = iso8601DateFormatter(
        [.withInternetDateTime, .withFractionalSeconds])
    
    static let iso8601 = iso8601DateFormatter([.withInternetDateTime])
    
    static let debugDateTimeFormatter = iso8601DateFormatter(
        [.withInternetDateTime, .withFractionalSeconds, .withSpaceBetweenDateAndTime])
    
    static func iso8601DateFormatter(_ formatOptions: ISO8601DateFormatter.Options) -> ISO8601DateFormatter {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = formatOptions
        dateFormatter.timeZone = Calendar.current.timeZone
        return dateFormatter
    }
}
