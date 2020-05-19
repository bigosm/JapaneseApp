//
//  LoginViewModel.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 10/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import ReSwift

public protocol LoginViewModelInputs {
    func loginButtonTapped()
    func setUsername(_ value: String)
    func setPassword(_ value: String)
    func viewDidLoad()
    func viewWillAppear()
    func viewWillDisappear()
}

public protocol LoginViewModelOutputs {
    var errorMessage: Observable<String?> { get }
    var username: Observable<String?> { get }
    var password: Observable<String?> { get }
    var isLoginButtonActive: Observable<Bool> { get }
    var isRequestInProcess: Observable<Bool> { get }
}

public protocol LoginViewModelType {
    var inputs: LoginViewModelInputs { get }
    var outputs: LoginViewModelOutputs { get }
}

public final class LoginViewModel: LoginViewModelType, LoginViewModelInputs, LoginViewModelOutputs, StoreSubscriber {
    public typealias StoreSubscriberStateType = UserSessionState
    
    // MARK: - Object Lifecycle
    
    public init() { }
    
    public func newState(state: UserSessionState) {
        isRequestInProcess.value = state == .requesting
        
        switch state {
        case .authorizationFailed(let error):
            errorMessage.value = error.localizedDescription
            setLoginButtonState()
        case .requesting:
            errorMessage.value = nil
            isLoginButtonActive.value = false
        case .unauthorized, .authorized:
            errorMessage.value = nil
            setLoginButtonState()
        }
    }
    
    // MARK: - Inputs
    
    public func loginButtonTapped() {
        guard let username = username.value,
            let password = password.value,
            !isRequestInProcess.value else {
            return
        }

        AppStore.shared.dispatch(
            UserActions.UserSession.login(username: username, password: password)
        )
    }
    
    public func setUsername(_ value: String) {
        username.value = value
        setLoginButtonState()
    }
    
    public func setPassword(_ value: String) {
        password.value = value
        setLoginButtonState()
    }
    
    public func viewDidLoad() { }
    
    public func viewWillAppear() {
        AppStore.shared.subscribe(self) {
            $0.select { $0.userSessionState }
        }
    }
    
    public func viewWillDisappear() {
        AppStore.shared.unsubscribe(self)
    }

    // MARK: - Outputs
    
    public let errorMessage: Observable<String?> = Observable(nil)
    public let username: Observable<String?> = Observable(nil)
    public let password: Observable<String?> = Observable(nil)
    public let isLoginButtonActive = Observable(false)
    public let isRequestInProcess = Observable(false)
    
    public var inputs: LoginViewModelInputs { return self }
    public var outputs: LoginViewModelOutputs { return self }
    
    // MARK: - Private methods
    
    private func setLoginButtonState() {
        if let username = username.value, let password = password.value {
            isLoginButtonActive.value = !username.isEmpty && !password.isEmpty
        } else {
            isLoginButtonActive.value = false
        }
    }
    
}
