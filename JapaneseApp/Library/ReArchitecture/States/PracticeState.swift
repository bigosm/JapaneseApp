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
    }
    
    public var current: Current = .noPractice
    public var practice: CurrentPracticeState?

}

public struct CurrentPracticeState: StateType, Equatable {
    
    public let questions: [Question]
    public var currentQuestionIndex: Int
    public var currentQuestion: Question {
        return self.questions[self.currentQuestionIndex]
    }
    public var currentQuestionAnswer: String?
    public var correctAnswerState: Bool?
    public var correctAnswer: String?
    public var answerMeaning: String?
    
    public var isReadingAidVisible = false
    public var hasReadingAid: Bool {
        switch self.currentQuestion {
        case .sentenceMeaning(_, let phrase, _):
            return phrase.value.contains { $0.readingAid != nil }
        case .subjectMeaning(_, let subject, _):
            return subject.readingAid != nil
        default:
            return false
        }
    }
}
