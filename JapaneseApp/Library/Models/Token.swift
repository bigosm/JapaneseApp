//
//  Token.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 16/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public struct Token: Codable, Equatable {
    var accessToken: String
    var expiresIn: Int
    var refreshExpiresIn: Int
    var refreshToken: String
    var tokenType: String
    var notBeforePolicy: Int
    var sessionState: String
    
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
