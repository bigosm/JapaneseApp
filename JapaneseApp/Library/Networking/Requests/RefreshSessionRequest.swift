//
//  RefreshSessionRequest.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 17/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

struct RefreshSessionRequest: APIRequest {
    typealias Response = Token
    
    let method = HTTPMethod.POST
    let resource = "auth/token"
    let requiresAuth = false
    var headers: [String: String] = [:]
    let body: BodyContent?
    
    init(refreshToken: String) {
        body = BodyContent(refresh_token: refreshToken)
    }

    struct BodyContent: Encodable, Equatable {
        let refresh_token: String
    }
}
