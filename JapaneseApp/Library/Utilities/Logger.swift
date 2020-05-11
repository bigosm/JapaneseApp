//
//  Logger.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 10/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public class Log {
    private static func debugPrint<T>(_ sign: String, _ notifier: T, _ item: Any) {
        #if DEBUG
        print("[\(sign)] [\(Date().iso8601)] [\(T.self)] - \(item)")
        #endif
    }

    public static func error<T>(_ notifier: T, item: Any) {
        debugPrint("❌", notifier, item)
    }

    public static func warning<T>(_ notifier: T, item: Any) {
        debugPrint("⚠️", notifier, item)
    }

    public static func info<T>(_ notifier: T, item: Any) {
        debugPrint("ℹ️", notifier, item)
    }

    public static func success<T>(_ notifier: T, item: Any) {
        debugPrint("✅", notifier, item)
    }
}
