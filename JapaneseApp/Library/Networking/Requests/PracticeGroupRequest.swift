//
//  PracticeGroupRequest.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 22/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

struct PracticeGroupRequest: APIRequest {
    typealias Response = PracticeGroupEnvelope
    
    let method = HTTPMethod.GET
    let resource = "practice-groups"
    var headers: [String: String] = [:]
    
}
