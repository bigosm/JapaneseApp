//
//  UserSessionState.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 10/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import ReSwift

public enum UserSessionState: StateType, Equatable {
    public static func == (lhs: UserSessionState, rhs: UserSessionState) -> Bool {
        switch (lhs, rhs) {
        case (.authorized(let lhs), .authorized(let rhs)): return lhs == rhs
        case (.unauthorized, .unauthorized),
             (.requesting, .requesting),
             (.authorizationFailed, .authorizationFailed):
            return true
        default: return false
        }
    }
    
    case authorizationFailed(Error)
    case authorized(Token)
    case requesting
    case unauthorized
}
