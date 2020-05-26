//
//  KanaCharactersRequest.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 23/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

struct KanaCharactersRequest: APIRequest {
    typealias Response = KanaCharacters
    
    let method = HTTPMethod.GET
    let resource = "kana-characters"
    let requiresAuth = false
    var headers: [String: String] = [:]
}
