//
//  UserProfileViewModel.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 08/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import ReSwift

public protocol UserProfileViewModelInputs {
    func viewDidLoad()
    func viewWillAppear()
    func viewWillDisappear()
}

public protocol UserProfileViewModelOutputs {
    var userName: Observable<String?> { get }
}

public protocol UserProfileViewModelType {
    var inputs: UserProfileViewModelInputs { get }
    var outputs: UserProfileViewModelOutputs { get }
}

public final class UserProfileViewModel: UserProfileViewModelType, UserProfileViewModelInputs, UserProfileViewModelOutputs, StoreSubscriber {
    public typealias StoreSubscriberStateType = UserProfileState
    
    // MARK: - Object Lifecycle
    
    public init() { }
    
    public func newState(state: UserProfileState) {

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
    
    public var inputs: UserProfileViewModelInputs { return self }
    public var outputs: UserProfileViewModelOutputs { return self }
    
    // MARK: - Private
}
