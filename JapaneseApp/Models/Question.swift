//
//  Question.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 03/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public class Question: Codable {
    
    // MARK: - Instance Properties
    
    public let answer: String
    public let hint: String?
    public let prompt: String
    public let wrongAnswers: [String]?
    
    public init(answer: String,
                hint:String?,
                prompt: String,
                wrongAnswers: [String]) {
        
        self.answer = answer
        self.hint = hint
        self.prompt = prompt
        self.wrongAnswers = wrongAnswers
    }
    
}
