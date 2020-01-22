//
//  QuestionAnswer.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 22/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public struct QuestionAnswer: Codable {
    
    // MARK: - Instance Properties
    
    public var question: Question
    public var selectedAnswer: String
    public var isCorrect: Bool {
        return self.question.answer == self.selectedAnswer
    }

}
