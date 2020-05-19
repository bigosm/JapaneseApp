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
    var preferredName: Observable<String?> { get }
    var username: Observable<String?> { get }
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
        guard let profile = state.profile else {
            preferredName.value = nil
            username.value = nil
            return
        }
        
        preferredName.value = getPrefferedUserName(fromProfile: profile)
        username.value = profile.username
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
    
    public let preferredName: Observable<String?> = Observable(nil)
    public let username: Observable<String?> = Observable(nil)
    
    public var inputs: UserProfileAboutViewModelInputs { return self }
    public var outputs: UserProfileAboutViewModelOutputs { return self }
    
    // MARK: - Private
    
    private func getPrefferedUserName(fromProfile profile: UserProfile) -> String {
        let userFullName = [profile.name, profile.surname]
            .compactMap { $0 }
            .joined(separator: " ")
        return profile.preferredUsername ??
            (userFullName.isEmpty ? profile.username : userFullName)
    }
}
