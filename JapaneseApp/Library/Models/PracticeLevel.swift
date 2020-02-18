//
//  QuestionLevel.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 30/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public struct PracticeLevel: Codable, Equatable {
    
    // MARK: - Instance Properties
    
    public let id: String
    public let level: Int
    public let characters: [String]
    public let vocabulary: [String]
    public let phrases: [String]
//    public let questions: [Question]
    
}
