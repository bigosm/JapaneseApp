//
//  Logger.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 10/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public class Log {
    
    private static func debugPrint(_ sign: String, _ item: Any) {
        #if DEBUG
        print("[\(sign)] [\(Date())] \(item)")
        #endif
    }

    public static func error(_ item: Any) {
        debugPrint("❌", item)
    }

    public static func warning(_ item: Any) {
        debugPrint("⚠️", item)
    }

    public static func info(_ item: Any) {
        debugPrint("ℹ️", item)
    }

    public static func success(_ item: Any) {
        debugPrint("✅", item)
    }
}
