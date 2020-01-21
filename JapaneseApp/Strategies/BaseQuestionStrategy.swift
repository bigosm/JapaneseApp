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
    public var numberOfQuestions: Int {
        return self.questions.count
    }
    public var currentQuestionAnswerObservable: Observable<String?> = Observable(nil)
    public var currentQuestionIndex: Int {
        return self.questionIndex
    }
    private var questionGroupCaretaker: QuestionGroupCaretaker
    private var questionGroup: QuestionGroup {
        return self.questionGroupCaretaker.selectedQuestionGroup
    }
    private var questionIndex = 0
    private var questions: [Question]
    private var questionsScore: QuestionScore
    
    // MARK: - Object Lifecycle
    
    public init(questionGroupCaretaker: QuestionGroupCaretaker,
                questions: [Question]) {
        
        self.questionGroupCaretaker = questionGroupCaretaker
        self.questions = questions
        self.questionsScore = QuestionScore(questionGroup: questionGroupCaretaker.selectedQuestionGroup)
    }
    
    // MARK: - QuestionStrategy

    public func advanceToNextQuestion(skip: Bool = false) -> Bool {
        try? self.questionGroupCaretaker.save()
        
        guard (self.questionIndex < self.questions.count - 1) || skip else {
            self.questions.forEach {

                let correctLabel = self.questionsScore.checkAnswerFor(question: $0) == true
                    ? "Correct!"
                    : "Correct answer: \($0.answer)."
                let questionAnswer = "Question: `\($0.prompt)`, "
                    + "your answer: \(self.questionsScore.answerFor(question: $0) ?? "--"), "
                    + correctLabel
                
                print(questionAnswer)
            }
            return false
        }
        
        if skip {
            let questionSkipped = self.questions.remove(at: self.questionIndex)
            self.questions.append(questionSkipped)
        } else {
            self.questionIndex += 1
        }
        
        self.currentQuestionAnswerObservable.value = nil
        
        return true
    }
    
    public func question(for index: Int) -> Question {
        return self.questions[index]
    }
    
    public func currentQuestion() -> Question {
        return self.questions[self.questionIndex]
    }
    
    public func feedAnswersFor(question: Question, amount: Int) -> [String] {
        let correctAnswer = question.answer
        let answersFeed = question.wrongAnswers?.shuffled().suffix(amount - 1) ?? []
        
        return ([correctAnswer] + answersFeed).shuffled()
    }
    
    public func checkAnswer() -> Bool? {
        guard let currentAnswer = self.currentQuestionAnswerObservable.value else {
            return nil
        }
        
        return self.questionsScore.answer(question: self.currentQuestion(), with: currentAnswer)
    }
    
    public func questionIndexTitle() -> String {
        return "\(self.questionIndex + 1)/\(self.questions.count)"
    }
    
}
