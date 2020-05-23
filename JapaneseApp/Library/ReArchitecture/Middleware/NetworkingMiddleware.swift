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
                DispatchQueue.main.async {
                    dispatch(UserActions.UserSession.login(username: "Michal@example.com", password: "123456"))
                }
                return
            }

            let networking = Networking.shared
            networking.currentAction = action
            
            switch action {
            case UserActions.UserSession.login(let username, let password):
                next(networking.request(
                    LoginRequest(username: username, password: password),
                    AppActions.RequestResult.Login.init))

            case AppActions.Request.refreshSession:
                guard case .authorized(let token) = getState()?.userSessionState else { return }
                next(networking.request(
                    RefreshSessionRequest(refreshToken: token.refreshToken),
                    AppActions.RequestResult.RefreshSession.init))
                
            case let action as AppActions.RequestResult.RefreshSession:
                switch action.state {
                case .success(_):
                    networking.refreshActions()
                    next(action)
                case .failure(_):
                    next(AppActions.UserSession.sessionExpired)
                case .inProgress:
                    next(action)
                }
                
            case AppActions.Request.getUserProfile:
                next(networking.request(
                    UserProfileRequest(),
                    AppActions.RequestResult.UserProfile.init))
                
            case AppActions.Request.getPracticeGroups:
                next(networking.request(
                    PracticeGroupRequest(),
                    AppActions.RequestResult.PracticeGroups.init))
                
            case AppActions.Request.getKanaCharacters:
                next(networking.request(
                    KanaCharactersRequest(),
                    AppActions.RequestResult.KanaCharacters.init))
                
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
    
    typealias NetworkAction<T> = AppActions.RequestResult.Request<T>
    
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
                self?.dispatch(action(.success(response!)))
            case .failure(let error):
                if request.requiresAuth,
                    let error = error as? URLSession.Error,
                    case .server(401, _) = error {
                    self?.markActionForRefresh(actionId: task.id)
                    self?.dispatch(AppActions.Request.refreshSession)
                } else {
                    self?.solveTask(withId: task.id)
                    self?.dispatch(action(.failure(error)))
                }
            }
        }
        
        return action(.inProgress)
    }
}


