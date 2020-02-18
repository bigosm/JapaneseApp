//
//  CurrentPracticeReducer.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 07/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import ReSwift

internal func practiceReducer(action: Action, state: PracticeState?) -> PracticeState {
    let state = state ?? PracticeState()
    
    guard let practiceAction = action as? PracticeAction else {
        return PracticeState(
            current: state.current,
            practice: currentPracticeReducer(action: action, state: state.practice)
        )
    }
    
    switch practiceAction {
    case .cancel:
        return PracticeState(
            current: .noPractice,
            practice: currentPracticeReducer(action: action, state: state.practice)
        )
    case .startPractice(let questionGroup),
         .startTimePractice(let questionGroup):
        return PracticeState(
            current: .inProgress(questionGroup),
            practice: currentPracticeReducer(action: action, state: state.practice)
        )
    }
}

internal func currentPracticeReducer(action: Action, state: CurrentPracticeState?) -> CurrentPracticeState? {

    if let action = action as? PracticeAction {
        switch action {
        case .cancel: return nil
        case .startPractice(let questionGroup),
             .startTimePractice(let questionGroup):
            let questions = QuestionFactory(practiceGroup: questionGroup, level: 1).prepare()
            return CurrentPracticeState(
                questions: questions,
                currentQuestionIndex: 0,
                currentQuestionAnswer: nil,
                correctAnswerState: nil,
                isReadingAidVisible: false
            )
        }
    }
    
    guard let action = action as? CurrentPracticeAction, let currentState = state else {
        return state
    }

    switch action {
    case .answer(let answer):
        if let _ = currentState.correctAnswerState {
            print("Answer Already checked.")
            return currentState
        }
        return CurrentPracticeState(
            questions: currentState.questions,
            currentQuestionIndex: currentState.currentQuestionIndex,
            currentQuestionAnswer: answer,
            correctAnswerState: nil,
            isReadingAidVisible: false
        )
    case .toggleReadingAid:
        return CurrentPracticeState(
            questions: currentState.questions,
            currentQuestionIndex: currentState.currentQuestionIndex,
            currentQuestionAnswer: currentState.currentQuestionAnswer,
            correctAnswerState: currentState.correctAnswerState,
            isReadingAidVisible: !currentState.isReadingAidVisible
        )
    case .checkAnswer:
        if let _ = currentState.correctAnswerState {
            print("Answer Already checked.")
            return currentState
        }
        return CurrentPracticeState(
            questions: currentState.questions,
            currentQuestionIndex: currentState.currentQuestionIndex,
            currentQuestionAnswer: currentState.currentQuestionAnswer,
            correctAnswerState: checkAnswer(state: currentState),
            isReadingAidVisible: currentState.isReadingAidVisible
        )
    case .nextQuestion:
        return CurrentPracticeState(
            questions: currentState.questions,
            currentQuestionIndex: currentState.currentQuestionIndex + 1,
            currentQuestionAnswer: nil,
            correctAnswerState: nil,
            isReadingAidVisible: false
        )
    }
}

fileprivate func checkAnswer(state: CurrentPracticeState) -> Bool {
    guard let answer = state.currentQuestionAnswer else {
        fatalError("Answer should be set, before checking.")
    }
    
    switch state.currentQuestion {
    case .sentenceMeaning(_, _, let answers),
         .subjectMeaning(_, _, let answers):
        return answers.contains(answer)
    case .translateMeaning(_, _, let answers):
        return true
    }
}
