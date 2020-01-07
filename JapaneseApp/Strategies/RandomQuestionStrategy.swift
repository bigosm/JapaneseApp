//
//  RandomQuestionStrategy.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 07/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import GameplayKit.GKRandomSource

public class RandomQuestionStrategy: QuestionStrategy {
    
    //MARK: - Properties
    
    public var title: String {
        return self.questionGroup.title
    }
    
    public var correctCount: Int = 0
    public var incorrectCount: Int = 0
    
    private let questionGroup: QuestionGroup
    private var questionIndex = 0
    private let questions: [Question]
    
    // MARK: - Object Lifecycle
    
    public init(questionGroup: QuestionGroup) {
        self.questionGroup = questionGroup
        
        let randomSource = GKRandomSource.sharedRandom()
        self.questions = randomSource.arrayByShufflingObjects(in: self.questionGroup.questions) as! [Question]
    }
    
    // MARK: - QuestionStrategy
    
    public func advanceToNextQuestion() -> Bool {
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
