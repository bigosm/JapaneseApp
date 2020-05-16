//
//  LoginRequest.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 15/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

struct LoginRequest: APIRequest {
    typealias Response = Token
    
    let method = HTTPMethod.POST
    let resource = "auth/token"
    let body: BodyContent?
    
    init(username: String, password: String) {
        body = BodyContent(username: username, password: password)
    }

    struct BodyContent: Encodable, Equatable {
        let username: String
        let password: String
    }
}
