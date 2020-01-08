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
    public var correctCount: Int {
        get { return self.questionGroup.score.correctCount }
        set { self.questionGroup.score.correctCount = newValue }
    }
    public var incorrectCount: Int {
        get { return self.questionGroup.score.incorrectCount }
        set { self.questionGroup.score.incorrectCount = newValue }
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
        
        self.questionGroupCaretaker.selectedQuestionGroup.score.reset()
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
    
    public func markQuestionCorrect(_ question: Question) {
        self.correctCount += 1
    }
    
    public func markQuestionIncorrect(_ question: Question) {
        self.incorrectCount += 1
    }
    
    public func questionIndexTitle() -> String {
        return "\(self.questionIndex + 1)/\(self.questions.count)"
    }
    
}
