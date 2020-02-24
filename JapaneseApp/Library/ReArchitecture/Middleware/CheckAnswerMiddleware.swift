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

    let x = state.currentQuestion.correctAnswerList.first { $0.lowercased() == answer.lowercased() }
    let isCorrect = x != nil
    let correctAnswer = isCorrect ? nil : state.currentQuestion.correctAnswerList.first
    
    return .answerState(AnswerCheck(
        answer: answer,
        isCorrect: isCorrect,
        correctAnswer: correctAnswer,
        answerMeaning: nil))
}
