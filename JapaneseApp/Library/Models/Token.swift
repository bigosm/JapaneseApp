//
//  Token.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 16/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public struct Token: Codable, Equatable {
    let accessToken: String
    let expiresIn: Int
    let refreshExpiresIn: Int
    let refreshToken: String
    let tokenType: String
    let notBeforePolicy: Int
    let sessionState: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expiresIn = "expires_in"
        case notBeforePolicy = "not-before-policy"
        case refreshExpiresIn = "refresh_expires_in"
        case refreshToken = "refresh_token"
        case tokenType = "token_type"
        case sessionState = "session_state"
    }
}
