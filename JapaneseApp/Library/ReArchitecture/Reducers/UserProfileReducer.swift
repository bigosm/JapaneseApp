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
    
    return state
}
