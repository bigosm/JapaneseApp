//
//  Experience.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 30/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation


public struct Experience: Codable, Equatable {
    
    public var totalExperience: Int
    public var currentLevelExperience: Int
    public var nextLevelExperience: Int
    public var level: Int
    
}
