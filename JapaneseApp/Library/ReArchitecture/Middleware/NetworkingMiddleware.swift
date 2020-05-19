//
//  NetworkingMiddleware.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 11/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import ReSwift

internal let networkingMiddleware: Middleware<AppState> = { dispatch, getState in
    return { next in
        return { action in
            
            guard !(action is ReSwiftInit) else {
                next(action)
                return
            }

            let networking = Networking.shared
            networking.currentAction = action
            
            switch action {
            case UserActions.UserSession.login(let username, let password):
                next(networking.request(
                    LoginRequest(username: username, password: password),
                    AppActions.Networking.Login.init))

            case AppActions.UserSession.refreshSession:
                guard case .authorized(let token) = getState()?.userSessionState else { return }
                next(networking.request(
                    RefreshSessionRequest(refreshToken: token.refreshToken),
                    AppActions.Networking.RefreshSession.init))
                
            case let action as AppActions.Networking.RefreshSession:
                switch action.state {
                case .success(_):
                    networking.refreshActions()
                    next(action)
                case .failure(_):
                    next(AppActions.UserSession.sessionExpired)
                case .inProgress:
                    next(action)
                }
                
            case AppActions.UserProfile.getUserProfile:
                next(networking.request(
                    UserProfileRequest(),
                    AppActions.Networking.UserProfile.init))
                
            default:
                next(action)
            }
        }
    }
}

class Networking {
    static var shared = Networking()
    var currentAction: Action?
    
    let dispatch: DispatchFunction
    let getState: () -> AppState?

    init(
        dispatch: @escaping DispatchFunction = AppStore.shared.dispatch,
        getState: @escaping () -> AppState? = { AppStore.shared.state }) {
        self.dispatch = dispatch
        self.getState = getState
    }

    func refreshActions() {
        Log.info("💚 \(#function)")
    }
    
    func markActionForRefresh(actionId id: UUID) {
        Log.info("💚 \(#function)")
    }
    
    func addTaskToCurrentAction(_ task: APIClientTaskType) {
        Log.info("💚 \(#function)")
    }
    
    func solveTask(withId id: UUID) {
        Log.info("💚 \(#function)")
    }
    
    var inProgress: [UUID: (task: APIClientTaskType, action: Action)] = [:]
    var pending: [UUID: (task: APIClientTaskType, action: Action)] = [:]
    
    typealias NetworkAction<T> = AppActions.Networking.Request<T>
    
    func request<T: APIRequest>(
        _ request: T,
        _ action: @escaping (NetworkAction<T.Response>.State<T.Response>) -> NetworkAction<T.Response>
    ) -> Action {
        guard let store = getState() else {
            fatalError("Network request performed before store initialization.")
        }
        
        var request = request
        
        if request.requiresAuth, case .authorized(let token) = store.userSessionState {
            request.headers["Authorization"] = token.accessToken
        }
    
        let task = store.urlSession.request(request)

        addTaskToCurrentAction(task)
        
        task.resume()
        
        task.promise.observe { [weak self] result in
            switch result {
            case .success(let response):
                self?.solveTask(withId: task.id)
                print(response!)
                self?.dispatch(action(.success(response!)))
            case .failure(let error):
                if request.requiresAuth,
                    let error = error as? URLSession.Error,
                    case .server(401, _) = error {
                    self?.markActionForRefresh(actionId: task.id)
                    self?.dispatch(AppActions.UserSession.refreshSession)
                } else {
                    self?.solveTask(withId: task.id)
                    self?.dispatch(action(.failure(error)))
                }
            }
        }
        
        return action(.inProgress)
    }
}


