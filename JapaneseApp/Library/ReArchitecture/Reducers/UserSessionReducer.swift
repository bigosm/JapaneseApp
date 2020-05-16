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
    case AppActions.UserSessionAction.loginRequestSuccessful(let token):
        return UserSessionState.authorized(token)
    case AppActions.UserSessionAction.loginRequestFailed(let error):
        return UserSessionState.authorizationFailed(error)
    case AppActions.UserSessionAction.loginRequestInProgress:
        return UserSessionState.requesting
    case AppActions.UserSessionAction.unauthorized,
         UserActions.UserSessionAction.logout:
        return UserSessionState.unauthorized
    default:
        return state ?? UserSessionState.unauthorized
    }
}
