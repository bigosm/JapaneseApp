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
    case let action as AppActions.RequestResult.Login:
        switch action.state {
        case .success(let token):
            return UserSessionState.authorized(token)
        case .failure(let error):
            return UserSessionState.authorizationFailed(error)
        case .inProgress:
            return UserSessionState.requesting
        }
    case AppActions.UserSession.sessionExpired,
         UserActions.UserSession.logout:
        return UserSessionState.unauthorized
    default:
        return state ?? UserSessionState.unauthorized
    }
}
