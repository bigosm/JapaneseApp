//
//  CheckAnswerMiddleware.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 18/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import ReSwift

internal let checkAnswerMiddleware: Middleware<AppState> = { dispatch, getState in
    return { next in
        return { action in
            guard case CurrentPracticeAction.checkAnswer = action else {
                next(action)
                return
            }
            next(checkAnswer(state: getState()?.practiceState.practice))
        }
    }
}

fileprivate func checkAnswer(state: CurrentPracticeState?) -> CurrentPracticeAction {
    guard let state = state, let answer = state.currentQuestionAnswer else {
        fatalError("Answer should be set, before checking.")
    }
    let isCorrect: Bool
    let correctAnswer: String?
    let meaning: String?
    switch state.currentQuestion {
    case .sentenceMeaning(_, _, let answers):
        isCorrect = answers.map { $0.lowercased() }.contains(answer.lowercased())
        correctAnswer = isCorrect ? nil : answers.first
        meaning = nil
    case .subjectMeaning(_, _, let answers):
        isCorrect = answers.map { $0.lowercased() }.contains(answer.lowercased())
        correctAnswer = isCorrect ? nil : answers.first
        meaning = nil
    case .translateMeaning(_, _, let answers):
        let possibleAnswers = answers.compactMap { $0.meaning }.flatMap { $0 }
        isCorrect = possibleAnswers.map { $0.lowercased() }.contains(answer.lowercased())
        correctAnswer = isCorrect ? nil : possibleAnswers.first(where: { $0.lowercased() == answer.lowercased() })
        meaning = nil
    }
    
    return .answerState(isCorrect: isCorrect, correctAnswer: correctAnswer, meaning: meaning)
}
