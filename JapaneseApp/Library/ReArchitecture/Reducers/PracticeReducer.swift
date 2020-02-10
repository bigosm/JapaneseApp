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
    guard let action = action as? PracticeAction else {
        return state ?? PracticeState(current: .noPractice)
    }
    
    let state = state ?? PracticeState()

    switch action {
    case .cancel:
        return PracticeState()
    case .toggleReadingAid:
        return PracticeState(
            current: state.current,
            practice: state.practice,
            currentQuestion: state.currentQuestion,
            isReadingAidVisible: !state.isReadingAidVisible
        )
    case .startPractice(let questionGroup):
        let practice = PracticeFactory(practiceGroup: questionGroup, level: 1).prepare()
        return PracticeState(
            current: .inProgress(questionGroup),
            practice: practice,
            currentQuestion: practice.questions.first,
            isReadingAidVisible: state.isReadingAidVisible
        )
    case .startTimePractice(let questionGroup):
        let practice = PracticeFactory(practiceGroup: questionGroup, level: 1).prepare()
        return PracticeState(
            current: .inProgress(questionGroup),
            practice: practice,
            currentQuestion: practice.questions.first,
            isReadingAidVisible: state.isReadingAidVisible
        )
    }
}
