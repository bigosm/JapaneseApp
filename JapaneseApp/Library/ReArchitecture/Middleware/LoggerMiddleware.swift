//
//  LoggerMiddleware.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 15/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import ReSwift

internal let loggerMiddleware: Middleware<AppState> = { dispatch, getState in
    return { next in
        return { action in
            Log.info("[🔸 Action] [\(type(of: action))] \(action)")
            next(action)
        }
    }
}
