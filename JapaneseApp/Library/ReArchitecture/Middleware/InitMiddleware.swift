//
//  InitMiddleware.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 23/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import ReSwift

internal let initMiddleware: Middleware<AppState> = { dispatch, getState in
    return { next in
        return { action in
            guard let reSwiftInit = action as? ReSwiftInit else {
                next(action)
                return
            }
            next(reSwiftInit)
            DispatchQueue.main.async {
                dispatch(AppActions.Request.getKanaCharacters)
            }
        }
    }
}
