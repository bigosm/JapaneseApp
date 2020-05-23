//
//  UserProfileReducer.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 08/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import ReSwift

internal func userProfileReducer(action: Action, state: UserProfileState?) -> UserProfileState {
    let state = state ?? UserProfileState(profile: nil)
    
    switch action {
    case let action as AppActions.RequestResult.UserProfile:
        switch action.state {
        case .success(let userProfile):
            return UserProfileState(profile: userProfile)
        case .failure(_):
            return UserProfileState(profile: nil)
        case .inProgress:
            return UserProfileState(profile: nil)
        }
    default:
        return state
    }
}
