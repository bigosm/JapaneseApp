//
//  UserProfileAboutViewModel.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 08/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import ReSwift

public protocol UserProfileAboutViewModelInputs {
    func viewDidLoad()
    func viewWillAppear()
    func viewWillDisappear()
}

public protocol UserProfileAboutViewModelOutputs {
    var userName: Observable<String?> { get }
}

public protocol UserProfileAboutViewModelType {
    var inputs: UserProfileAboutViewModelInputs { get }
    var outputs: UserProfileAboutViewModelOutputs { get }
}

public final class UserProfileAboutViewModel: UserProfileAboutViewModelType, UserProfileAboutViewModelInputs, UserProfileAboutViewModelOutputs, StoreSubscriber {
    public typealias StoreSubscriberStateType = UserProfileState
    
    // MARK: - Object Lifecycle
    
    public init() { }
    
    public func newState(state: UserProfileState) {
        userName.value = state.profile?.name
    }
    
    // MARK: - Inputs
    
    public func viewDidLoad() {
        
    }
    
    public func viewWillAppear() {
        AppStore.shared.subscribe(self) {
            $0.select { $0.userProfileState }
        }
    }
    
    public func viewWillDisappear() {
        AppStore.shared.unsubscribe(self)
    }
    
    // MARK: - Outputs
    
    public let userName: Observable<String?> = Observable(nil)
    
    public var inputs: UserProfileAboutViewModelInputs { return self }
    public var outputs: UserProfileAboutViewModelOutputs { return self }
    
    // MARK: - Private
}
