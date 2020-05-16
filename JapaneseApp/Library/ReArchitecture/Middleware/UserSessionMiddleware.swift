//
//  sessionMiddleware.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 11/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import ReSwift


internal let userSessionMiddleware: Middleware<AppState> = { dispatch, getState in
    return { next in
        return { action in
            switch action {
            case UserActions.UserSessionAction.login(username: let username, password: let password):
                guard let state = getState() else { return }
                
                let apiClientTask = state.urlSession.request(LoginRequest(username: username, password: password))
                apiClientTask.send()
                apiClientTask.promise.observe { result in
                    switch result {
                    case .success(let response):
                        dispatch(
                            AppActions.UserSessionAction.loginRequestSuccessful(response!)
                        )
                    case .failure(let error):
                        dispatch(
                            AppActions.UserSessionAction.loginRequestFailed(error)
                        )
                    }
                }
                next(AppActions.UserSessionAction.loginRequestInProgress)
            default:
                next(action)
            }
        }
    }
}



let x: () -> URLSessionDataTask = {
    let task = URLSession.shared.dataTask(with: URL(string: "http://exmaple.com")!) { data, response, error in
        
    }
    task.resume()
    return task
}
