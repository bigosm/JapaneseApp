//
//  QuestionGroupAnswers.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 22/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public class QuestionGroupAnswers: Codable {
    
    // MARK: - Instance Properties
    
    public var endDate: Date?
    public var questionAnswers: [QuestionAnswer]
    public var experienceEarned = 0
    public var startDate: Date
    
    // MARK: - Object Lifecycle

    init(questionAnswers: [QuestionAnswer]) {
        self.questionAnswers = questionAnswers
        self.startDate = Date()
    }
    
    // MARK: - Instance Methods
    
    public func answer(question: Question, selectedAnswer answer: String) -> Bool {
        let questionAnswer = QuestionAnswer(question: question, selectedAnswer: answer)
        self.questionAnswers.append(questionAnswer)
        return questionAnswer.isCorrect
    }
    
    public func answer(forQuestion question: Question) -> String? {
        return self.questionAnswer(forQuestion: question)?.selectedAnswer
    }
    
    public func isAnswerCorrect(forQuestion question: Question) -> Bool? {
        return self.questionAnswer(forQuestion: question)?.isCorrect
    }
    
    // MARK: - Private Methods
    
    private func questionAnswer(forQuestion question: Question) -> QuestionAnswer? {
        return self.questionAnswers.first { $0.question === question }
    }
    
}
