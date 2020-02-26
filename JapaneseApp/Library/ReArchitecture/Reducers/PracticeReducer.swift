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
    let state = state ?? PracticeState(current: .noPractice, practice: nil)
    
    guard let practiceAction = action as? PracticeAction else {
        return PracticeState(
            current: state.current,
            practice: currentPracticeReducer(action: action, state: state.practice)
        )
    }
    
    switch practiceAction {
    case .cancel, .finish:
        return PracticeState(
            current: .noPractice,
            practice: currentPracticeReducer(action: action, state: state.practice)
        )
    case .startPractice(let practiceGroup),
         .startTimePractice(let practiceGroup):
        return PracticeState(
            current: .inProgress(practiceGroup),
            practice: currentPracticeReducer(action: action, state: state.practice)
        )
    case .complete(let practiceGroup):
        return PracticeState(
            current: .completed(practiceGroup),
            practice: currentPracticeReducer(action: action, state: state.practice)
        )
    case .selectPracticeAnswerAtIndex(let index):
        guard case .completed(_) = state.current else {
            fatalError("Need 'complete' current status.")
        }
        return PracticeState(
            current: state.current,
            practice: currentPracticeReducer(action: action, state: state.practice)
        )
    }
}

internal func currentPracticeReducer(action: Action, state: CurrentPracticeState?) -> CurrentPracticeState? {

    if let action = action as? PracticeAction {
        switch action {
        case .cancel, .finish: return nil
        case .startPractice(let practiceGroup),
             .startTimePractice(let practiceGroup):
            let questions = QuestionFactory(practiceGroup: practiceGroup, level: 3).prepare()
            guard questions.count > 0 else {
                fatalError("Can not start practice without questions!")
            }
            return CurrentPracticeState(
                questions: questions,
                currentQuestionIndex: 0,
                currentQuestionAnswer: nil,
                answerCheck: nil,
                isReadingAidVisible: false,
                practiceAnswers: [],
                selectedPracticeAnswer: nil
            )
        case .complete(_):
            guard let state = state else { fatalError("state should be defined.") }
            return CurrentPracticeState(
                questions: state.questions,
                currentQuestionIndex: 0,
                currentQuestionAnswer: nil,
                answerCheck: nil,
                isReadingAidVisible: false,
                practiceAnswers: state.practiceAnswers,
                selectedPracticeAnswer: nil
            )
        case .selectPracticeAnswerAtIndex(let index):
            guard let state = state else { fatalError("state should be defined.") }
            return CurrentPracticeState(
                questions: state.questions,
                currentQuestionIndex: 0,
                currentQuestionAnswer: nil,
                answerCheck: nil,
                isReadingAidVisible: false,
                practiceAnswers: state.practiceAnswers,
                selectedPracticeAnswer: state.practiceAnswers[index]
            )
        }
    }
    
    guard let action = action as? CurrentPracticeAction, let currentState = state else {
        return state
    }

    switch action {
    case .answer(let answer):
        if let _ = currentState.answerCheck {
            print("Answer is checked, can't do that action right now!")
            return currentState
        }
        return CurrentPracticeState(
            questions: currentState.questions,
            currentQuestionIndex: currentState.currentQuestionIndex,
            currentQuestionAnswer: answer,
            answerCheck: nil,
            isReadingAidVisible: currentState.isReadingAidVisible,
            practiceAnswers: currentState.practiceAnswers,
            selectedPracticeAnswer: nil
        )
    case .answerState(let answerCheck):
        return CurrentPracticeState(
            questions: currentState.questions,
            currentQuestionIndex: currentState.currentQuestionIndex,
            currentQuestionAnswer: currentState.currentQuestionAnswer,
            answerCheck: answerCheck,
            isReadingAidVisible: currentState.isReadingAidVisible,
            practiceAnswers: currentState.practiceAnswers + [answerCheck],
            selectedPracticeAnswer: nil
        )
    case .toggleReadingAid:
        return CurrentPracticeState(
            questions: currentState.questions,
            currentQuestionIndex: currentState.currentQuestionIndex,
            currentQuestionAnswer: currentState.currentQuestionAnswer,
            answerCheck: nil,
            isReadingAidVisible: !currentState.isReadingAidVisible,
            practiceAnswers: currentState.practiceAnswers,
            selectedPracticeAnswer: nil
        )
    case .checkAnswer:
        fatalError("Action should be swallowed in middleware.")
    case .nextQuestion:
        return CurrentPracticeState(
            questions: currentState.questions,
            currentQuestionIndex: currentState.currentQuestionIndex + 1,
            currentQuestionAnswer: nil,
            answerCheck: nil,
            isReadingAidVisible: false,
            practiceAnswers: currentState.practiceAnswers,
            selectedPracticeAnswer: nil
        )
    }
}
