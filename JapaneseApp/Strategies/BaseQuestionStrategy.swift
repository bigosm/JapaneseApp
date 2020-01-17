//
//  BaseQuestionStrategy.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 08/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public class BaseQuestionStrategy: QuestionStrategy {
    
    //MARK: - Properties
    
    public var title: String {
        return self.questionGroup.title
    }

    private var questionGroupCaretaker: QuestionGroupCaretaker
    private var questionGroup: QuestionGroup {
        return self.questionGroupCaretaker.selectedQuestionGroup
    }
    private var questionIndex = 0
    private let questions: [Question]
    
    // MARK: - Object Lifecycle
    
    public init(questionGroupCaretaker: QuestionGroupCaretaker,
                questions: [Question]) {
        
        self.questionGroupCaretaker = questionGroupCaretaker
        self.questions = questions
    }
    
    // MARK: - QuestionStrategy
    
    public func advanceToNextQuestion() -> Bool {
        try? self.questionGroupCaretaker.save()
        
        guard self.questionIndex < self.questions.count - 1 else {
            return false
        }
        self.questionIndex += 1
        return true
    }
    
    public func currentQuestion() -> Question {
        return self.questions[self.questionIndex]
    }
    
    public func getAnswersForCurrentQuestion(amount: Int) -> [String] {
        let question = self.currentQuestion()
        let correctAnswer = question.answer
        let answersFeed = question.wrongAnswers?.shuffled().suffix(amount - 1) ?? []
        
        return ([correctAnswer] + answersFeed).shuffled()
    }
    
    public func checkAnswer(selected answer: String) -> Bool {
        return self.currentQuestion().answer == answer
    }
    
    public func markQuestionCorrect(_ question: Question) {
    }
    
    public func markQuestionIncorrect(_ question: Question) {
    }
    
    public func questionIndexTitle() -> String {
        return "\(self.questionIndex + 1)/\(self.questions.count)"
    }
    
}
