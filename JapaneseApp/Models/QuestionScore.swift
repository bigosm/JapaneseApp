//
//  QuestionScore.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 20/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public class QuestionScore {
    
    public struct QuestionAnswer {
        public var question: Question
        public var selectedAnswer: String
        
        public func isCorrect() -> Bool {
            return self.question.answer == self.selectedAnswer        }
    }
    
    public var questionGroup: QuestionGroup
    private var questionAnwers: [QuestionAnswer] = []
    
    
    public var numberOfQuestions: Int {
        return self.questionGroup.questions.count
    }
    
    init(questionGroup: QuestionGroup) {
        self.questionGroup = questionGroup
    }
    
    public func answer(question: Question, with answer: String) -> Bool {
        let questionAnswer = QuestionAnswer(question: question, selectedAnswer: answer)
        self.questionAnwers.append(questionAnswer)
        
        return questionAnswer.isCorrect()
    }
    
    public func checkAnswerFor(question: Question) -> Bool? {
        return self.questionAnswer(for: question)?.isCorrect()
    }
    
    public func answerFor(question: Question) -> String? {
        return self.questionAnswer(for: question)?.selectedAnswer
    }
    
    private func questionAnswer(for question: Question) -> QuestionAnswer? {
        return self.questionAnwers.first(where: { $0.question === question })
    }
    
    
}
