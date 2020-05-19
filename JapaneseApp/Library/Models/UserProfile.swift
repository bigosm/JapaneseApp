//
//  UserProfile.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 08/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public struct UserProfile: Codable, Equatable {
    public let username: String
    public let email: String
    public let name: String?
    public let surname: String?
    public let prefferedUsername: String?
}
