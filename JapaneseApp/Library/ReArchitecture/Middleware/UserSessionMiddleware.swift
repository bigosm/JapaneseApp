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
            case is ReSwiftInit:
                next(action)

            case UserSessionAction.tryLogin(username: let username, password: let password):
                guard let state = getState() else { return }
                
                func login(username: String, password: String) -> Future<LoginRequest.Response?> {
                    let apiClientTask = state.urlSession.request(LoginRequest(username: username, password: password))
                    apiClientTask.send()
                    apiClientTask.promise.observe { result in
                        switch result {
                        case .success:
                            dispatch(
                                UserSessionAction.login(UserSession())
                            )
                        case .failure(let error):
                            dispatch(
                                UserSessionAction.loginAttemptFailed(error)
                            )
                        }
                    }
                    return apiClientTask.promise
                }

                

                next(UserSessionAction.loginRequestInProcess)
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
