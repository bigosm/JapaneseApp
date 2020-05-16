//
//  Date+Extension.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 15/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

extension Date {
    var iso8601WithFractionalSeconds: String {
        return Formatter.iso8601WithFractionalSeconds.string(from: self)
    }
    
    var iso8601: String {
        return Formatter.iso8601.string(from: self)
    }
}
