//
//  ReloginMiddleware.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 19/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import ReSwift

internal let reloginMiddleware: Middleware<AppState> = { dispatch, getState in
    return { next in
        return { action in
            next(action)
            
            switch action {
            case let action as AppActions.RequestResult.Login:
                if case .success = action.state {
                    prepareStore(dispatch, getState)
                }
            case UserActions.UserSession.logout,
                 AppActions.UserSession.sessionExpired:
                cleanStore(dispatch, getState)
            default:
                next(action)
            }
        }
    }
}

fileprivate func prepareStore(_ dispatch: DispatchFunction, _ getState: () -> AppState?) {
    dispatch(AppActions.Request.getUserProfile)
    dispatch(AppActions.Request.getPracticeGroups)
}

fileprivate func cleanStore(_ dispatch: DispatchFunction, _ getState: () -> AppState?)  {
    
}
