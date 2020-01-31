//
//  QuestionStrategy.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 07/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public protocol QuestionStrategy: AnyObject {
    
    var didCompleteQuestionGroup: ((QuestionGroupHandler) -> Void)? { get set }
    var title: String { get }
    var numberOfQuestions: Int { get }
    var currentQuestionAnswerObservable: Observable<String?> { get }
    var currentQuestionIndex: Int { get }
    
    func completeQuestionGroup()
    func advanceToNextQuestion(skip: Bool) -> Bool
    func question(for index: Int) -> Question
    func currentQuestion() -> Question
    func feedAnswersFor(question: Question, amount: Int) -> [String]
    func checkAnswer() -> Bool?
    func questionIndexTitle() -> String
    
}
