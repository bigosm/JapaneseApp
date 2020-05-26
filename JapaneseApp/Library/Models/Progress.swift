//
//  Progress.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 22/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public struct Progress: Codable, Equatable {
    let entityId: String
    let createdAt: Date
    let updatedAt: Date
    let count: Int
}
