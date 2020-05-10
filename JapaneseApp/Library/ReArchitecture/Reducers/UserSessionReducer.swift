//
//  UserSessionReducer.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 10/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import ReSwift

internal func userSessionReducer(action: Action, state: UserSessionState?) -> UserSessionState {
    switch action {
    case UserSessionAction.login(let userSession):
        return UserSessionState.loggedIn(userSession)
    case UserSessionAction.logout:
        return UserSessionState.loggedOut
    default:
        return state ?? UserSessionState.loggedOut
    }
}
