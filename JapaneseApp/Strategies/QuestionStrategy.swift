//
//  QuestionStrategy.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 07/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public protocol QuestionStrategy: AnyObject {
    
    /// The title of selected question group.
    var title: String { get }
    /// The value of correct answers
    var correctCount: Int { get }
    /// The value of incorrect Answers
    var incorrectCount: Int { get }
    
    /// <#Description#>
    func advanceToNextQuestion() -> Bool
    /// <#Description#>
    func currentQuestion() -> Question
    /// <#Description#>
    /// - Parameter question: <#question description#>
    func markQuestionCorrect(_ question: Question)
    /// <#Description#>
    /// - Parameter question: <#question description#>
    func markQuestionIncorrect(_ question: Question)
    /// <#Description#>
    func questionIndexTitle() -> String
    
}
