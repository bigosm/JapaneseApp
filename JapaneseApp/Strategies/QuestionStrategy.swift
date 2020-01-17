//
//  QuestionStrategy.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 07/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public protocol QuestionStrategy: AnyObject {
    

    var title: String { get }

    func advanceToNextQuestion() -> Bool
    func currentQuestion() -> Question
    func getAnswersForCurrentQuestion(amount: Int) -> [String]
    func checkAnswer(selected: String) -> Bool
    func markQuestionCorrect(_ question: Question)
    func markQuestionIncorrect(_ question: Question)
    func questionIndexTitle() -> String
    
}
