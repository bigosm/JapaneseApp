//
//  ProfileRequest.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 17/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

struct UserProfileRequest: APIRequest {
    typealias Response = UserProfile
    
    let method = HTTPMethod.GET
    let resource = "users/profile"
    var headers: [String: String] = [:]
    
}
