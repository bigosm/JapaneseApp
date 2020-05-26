//
//  VocabularyRequest.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 26/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

struct VocabularyRequest: APIRequest {
    typealias Response = [Subject]
    
    let method = HTTPMethod.GET
    let resource = "vocabulary"
    let requiresAuth = false
    var headers: [String: String] = [:]
}
