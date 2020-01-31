//
//  Question.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 03/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public struct Question: Codable {
    
    // MARK: - Instance Properties
    
    public let answer: String
    public let hint: String?
    public let prompt: String
    public let subject: String
    public let wrongAnswers: [String]?
    
}
