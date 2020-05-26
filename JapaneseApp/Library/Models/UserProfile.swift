//
//  UserProfile.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 08/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public struct UserProfile: Codable, Equatable {
    let username: String
    let email: String
    let name: String?
    let surname: String?
    let preferredUsername: String?
}
