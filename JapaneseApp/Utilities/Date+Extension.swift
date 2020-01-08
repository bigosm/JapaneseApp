//
//  Date+Extension.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 08/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public extension Date {
    
    var iso8601: String {
        return ISO8601DateFormatter().string(from: self)
    }
    
}
