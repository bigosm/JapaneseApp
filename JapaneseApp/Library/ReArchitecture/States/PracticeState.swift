//
//  CurrentlyPracticeState.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 07/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import ReSwift

public struct PracticeState: StateType, Equatable {

    public enum Current: Equatable {
        case noPractice
        case inProgress(PracticeGroup)
        case completed(PracticeGroup)
    }
    
    public let current: Current
    public let practice: CurrentPracticeState?

}

public struct CurrentPracticeState: StateType, Equatable {
    
    public let questions: [AnyQuestion]
    public let currentQuestionIndex: Int
    public var currentQuestion: QuestionType {
        return self.questions[self.currentQuestionIndex].value
    }
    public let currentQuestionAnswer: String?
    public let answerCheck: AnswerCheck?
    public let isReadingAidVisible: Bool
    public let practiceAnswers: [AnswerCheck]
    public let selectedPracticeAnswer: AnswerCheck?
    public func isSelected(answerCheck: AnswerCheck) -> Bool {
        return answerCheck == selectedPracticeAnswer
    }
}

public struct AnswerCheck: Equatable {
    public let answer: String
    public let isCorrect: Bool
    public let correctAnswer: String?
    public let answerMeaning: String?
}
