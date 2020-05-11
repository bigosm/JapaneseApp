//
//  UserSessionState.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 10/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import ReSwift

public struct UserSessionState: StateType, Equatable {
    
    public let userSession: UserSession?
    
}

extension UserSessionState {
    
    static var loggedOut: UserSessionState {
        UserSessionState(userSession: nil)
    }
    
    static let loggedIn: (UserSession) -> UserSessionState = { userSession in
        UserSessionState(userSession: userSession)
    }
    
}
